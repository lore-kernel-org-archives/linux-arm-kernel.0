From: joe@perches.com (Joe Perches)
Date: Thu, 02 Apr 2015 09:23:23 -0700
Subject: String literals in __init functions
In-Reply-To: <alpine.DEB.2.10.1504021558350.27469@digraph.polyomino.org.uk>
References: <5512F6C6.1020304@free.fr> <1427306517.2717.0.camel@perches.com>
 <5513FE2F.3040306@free.fr> <1427386390.15849.13.camel@perches.com>
 <CA+rthh9Fb2q+O_wicc6eNcbo6SzwOVZed=tnThJLF-xuoQ-+Cw@mail.gmail.com>
 <1427392393.15849.16.camel@perches.com>
 <CA+rthh8irf+tTSbomivu=bgN-L1k99TQ-q6UYgmMRC1PNOG7qw@mail.gmail.com>
 <20150326144058.56ef6916b00ad38030296089@linux-foundation.org>
 <1427407120.15849.34.camel@perches.com>
 <alpine.DEB.2.10.1504021558350.27469@digraph.polyomino.org.uk>
Message-ID: <1427991803.23434.27.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-04-02 at 16:00 +0000, Joseph Myers wrote:
> On Thu, 26 Mar 2015, Joe Perches wrote:
> > > I'd have thought that a function-wide
> > > 	__attribute__((__string_section__(foo))
> > > wouldn't be a ton of work to implement.
> > 
> > Maybe not.
> > 
> > Could some future version of gcc move string constants
> > in a function to a specific section marked in a manner
> > similar to what Andrew described above?
> 
> Putting string constants in a special section is an old project idea at 
> <http://gcc.gnu.org/projects/optimize.html#putting_constants_in_special_sections>.  

That's news to me.  Thanks for the link.

> I still think support for that would make sense.

That's good to know.

Do you know of a mechanism in place to prioritize
development for these optimization projects or is
this a placeholder for unscheduled or unresourced
TODOs?
