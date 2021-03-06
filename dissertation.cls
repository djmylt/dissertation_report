\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dissertation}[2012/05/04 UoB CS LaTeX class, Dan Page <page@cs.bris.ac.uk>]

\RequirePackage{pgfkeys}
\RequirePackage{pgfopts}

\pgfkeys{/dissertation/.cd,
  % options
      author/.store in=\dissertation@author,     % string
  supervisor/.store in=\dissertation@supervisor, % string
      degree/.store in=\dissertation@degree,     % [BSc|MEng|MSci|MSc|PhD]
       title/.store in=\dissertation@title,      % string
    subtitle/.store in=\dissertation@subtitle,   % string
        type/.store in=\dissertation@type,       % string
        year/.store in=\dissertation@year,       % string
  % defaults
      author = {},
  supervisor = {Dr. Raphaël Clifford and Dr. Benjamin Sach},
      degree = {MEng},
       title = {},
    subtitle = {},
        type = {},
        year = {\the\year}
}

\ProcessPgfOptions{/dissertation}
\LoadClass[10pt,a4paper,twoside]{book}

% see http://www.ctan.org/tex-archive/macros/latex/required/graphics
\RequirePackage{graphicx}
\DeclareGraphicsExtensions{.pdf}
% see http://www.ctan.org/tex-archive/macros/latex/required/amslatex/
\RequirePackage{amsmath}
\RequirePackage{amssymb}

% see http://www.ctan.org/tex-archive/macros/latex/contrib/adjustbox
\RequirePackage{adjustbox}
% see http://www.ctan.org/tex-archive/macros/latex/contrib/etoolbox
\RequirePackage{etoolbox}
% see http://www.ctan.org/tex-archive/macros/latex/contrib/fancyhdr
\RequirePackage{fancyhdr}
% see http://www.ctan.org/tex-archive/macros/latex/contrib/geometry
\RequirePackage{geometry}
% see http://www.ctan.org/tex-archive/macros/latex/contrib/datetime/
\RequirePackage{datetime}
% see http://www.ctan.org/tex-archive/macros/latex/contrib/algorithm2e
\RequirePackage[algochapter]{algorithm2e}
% see http://www.ctan.org/tex-archive/macros/latex/contrib/listings
\RequirePackage{listings}
% see http://www.ctan.org/tex-archive/macros/latex/contrib/url
\RequirePackage{url}
% see http://www.ctan.org/tex-archive/macros/latex/contrib/hyperref
\RequirePackage{hyperref}
% see http://www.ctan.org/tex-archive/macros/latex/contrib/lipsum
\RequirePackage{lipsum}

% see http://www.ctan.org/tex-archive/usergrps/dante/dtk
\RequirePackage{dtklogos}

\RequirePackage{tikz}
\usetikzlibrary{automata,positioning,arrows}

\RequirePackage{verbatim}

\makeatletter

% =============================================================================

% configure algorithms
\DontPrintSemicolon

% configure listings
\lstset{basicstyle=\ttfamily,captionpos=b}
\renewcommand{\lstlistlistingname}{List of Listings}

% configure hyperref
\hypersetup{colorlinks=true,bookmarks=false,urlcolor=red}

% configure style of table of contents
\setcounter{tocdepth}{1}

% configure style of bibliography
\bibliographystyle{plain}

% configure style of pages
\geometry{a4paper,lmargin=2.5cm,rmargin=2.5cm,tmargin=2.5cm,bmargin=2.5cm}

\fancypagestyle{plain}{
  \fancyhf{}

  \renewcommand{\headrulewidth}{0.5pt}
  \renewcommand{\footrulewidth}{0.5pt}

  \fancyfoot[C]{\thepage}
}

\fancypagestyle{marked}{
  \fancyhf{}

  \renewcommand{\headrulewidth}{0.5pt}
  \renewcommand{\footrulewidth}{0.5pt}

  \fancyhead[LO]{\slshape \rightmark}
  \fancyhead[RE]{\slshape  \leftmark}

  \fancyfoot[C]{\thepage}
}

\pagestyle{plain}

% add paragraph breaks
\setlength{\parskip}{1em}
\renewcommand{\baselinestretch}{1.1}
\setlength{\parindent}{0em}

% -----------------------------------------------------------------------------

% define macro to generate UoB title page

\renewcommand{\maketitle}{
  \newpage
  \thispagestyle{empty}

  \ifcsempty{dissertation@type}{}{
    \adjustbox{padding={5pt},frame={1pt},right}{Dissertation Type: \dissertation@type}
  }

  \vspace*{\fill}
  \begin{center}
          \includegraphics[scale=0.3]{logos/logo_uob_color}          \\
                       \vspace{1cm}
                DEPARTMENT OF COMPUTER SCIENCE                       \\

                       \vspace{3cm}
                 {\LARGE \dissertation@title}                        \\
  \ifcsempty{dissertation@subtitle}{}{{\Large \dissertation@subtitle \\}}
                       \vspace{1cm}
                 {\Large \dissertation@author}                       \\

                       \vspace{1cm}
                \rule{0.5\textwidth}{0.5pt}
                       \vspace{1cm}

        A dissertation submitted to the University of Bristol
        in accordance with the requirements of the degree of
  \mbox{\ifcsstring{dissertation@degree}{BSc} {Bachelor of Science}{}%
        \ifcsstring{dissertation@degree}{MEng}{Master   of Engineering}{}%
        \ifcsstring{dissertation@degree}{MSci}{Master   of Science}{}%
        \ifcsstring{dissertation@degree}{MSc} {Master   of Science}{}%
        \ifcsstring{dissertation@degree}{PhD} {Doctor   of Philosophy}{}%
  } in the Faculty of Engineering.                                

                       \vspace{1cm}
                \rule{0.5\textwidth}{0.5pt}
                       \vspace{1cm} 

                         \today

  \end{center}
  \vspace*{\fill}
}

% define macro to generate UoB declaration

\newcommand{\makedecl}{
  \newpage
  \thispagestyle{plain}

  \chapter*{Declaration}

  This dissertation is submitted to the University of Bristol in accordance 
  with the requirements of the degree of {\dissertation@degree} in the Faculty 
  of Engineering.  It has not been submitted for any other degree or diploma 
  of any examining body.  Except where specifically acknowledged, it is all 
  the work of the Author. 

  \vspace{6cm}

  \noindent {\dissertation@author}, \today
}

% define macros to mark front, main and back matter

\renewcommand{\frontmatter}{
  \cleardoublepage
  \pagestyle{plain}
  \pagenumbering{roman}
}
\renewcommand{\mainmatter}{
  \cleardoublepage
  \pagestyle{marked}
  \pagenumbering{arabic}
}
\renewcommand{\backmatter}{
  \cleardoublepage
  \pagestyle{marked}
}

% define macros to consistently generate dissertation type field

\newcommand{\typemeng}[1]{%
  \ifstrequal{#1}{E}{enterprise}{}%
  \ifstrequal{#1}{R}{research}{}%
}%
\newcommand{\typemsc}[3]{%
  $(#1,#2,#3)$%
}%

\newcommand\defeq{\mathrel{\overset{\makebox[0pt]{\mbox{\normalfont\tiny\sffamily def}}}{=}}}

% =============================================================================

\makeatother
