From: joseph@codesourcery.com (Joseph Myers)
Date: Thu, 2 Apr 2015 16:00:33 +0000
Subject: String literals in __init functions
In-Reply-To: <1427407120.15849.34.camel@perches.com>
References: <5512F6C6.1020304@free.fr> <1427306517.2717.0.camel@perches.com>
 <5513FE2F.3040306@free.fr> <1427386390.15849.13.camel@perches.com>
 <CA+rthh9Fb2q+O_wicc6eNcbo6SzwOVZed=tnThJLF-xuoQ-+Cw@mail.gmail.com>
 <1427392393.15849.16.camel@perches.com>
 <CA+rthh8irf+tTSbomivu=bgN-L1k99TQ-q6UYgmMRC1PNOG7qw@mail.gmail.com>
 <20150326144058.56ef6916b00ad38030296089@linux-foundation.org>
 <1427407120.15849.34.camel@perches.com>
Message-ID: <alpine.DEB.2.10.1504021558350.27469@digraph.polyomino.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Mar 2015, Joe Perches wrote:

> > I'd have thought that a function-wide
> > 	__attribute__((__string_section__(foo))
> > wouldn't be a ton of work to implement.
> 
> Maybe not.
> 
> Could some future version of gcc move string constants
> in a function to a specific section marked in a manner
> similar to what Andrew described above?

Putting string constants in a special section is an old project idea at 
<http://gcc.gnu.org/projects/optimize.html#putting_constants_in_special_sections>.  
I still think support for that would make sense.

-- 
Joseph S. Myers
joseph at codesourcery.com
