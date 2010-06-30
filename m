From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 30 Jun 2010 11:07:52 -0400 (EDT)
Subject: Pending patches for -rc
In-Reply-To: <20100630101223.GA24284@n2100.arm.linux.org.uk>
References: <20100630101223.GA24284@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1006301101521.24097@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Jun 2010, Russell King - ARM Linux wrote:

>  44 files changed, 659 insertions(+), 139 deletions(-)
> 
> and I think that if I try to push these to Linus, we'll be on the receipt
> of another complaint - quite rightfully too - the above does not look like
> bug fixes.
> 
> Therefore, I won't be pushing my master branch to Linus, but instead merging
> it into -devel and re-starting my master branch afresh.

I completely agree.  I think that "ARM: 6189/1: Add support for the 
MOVW/MOVT relocations in Thumb-2" could remain though.  All the rest 
from your list could certainly be deferred to the next merge window.


Nicolas
