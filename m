From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Tue, 23 May 2017 10:33:02 +0200
Subject: [PATCH 08/13] ARM: dts: armada-385-linksys: use binary unit
 prefixes
In-Reply-To: <20170522202416.1c48d91a@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
 <20170521124903.11050-9-ralph.sennhauser@gmail.com>
 <20170522150001.GM29447@lunn.ch>
 <20170522202416.1c48d91a@gmail.com>
Message-ID: <20170523103302.4f78eb93@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 May 2017 20:24:16 +0200
Ralph Sennhauser <ralph.sennhauser@gmail.com> wrote:

> On Mon, 22 May 2017 17:00:01 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > On Sun, May 21, 2017 at 02:48:57PM +0200, Ralph Sennhauser wrote:  
> > > Use IEEE 1541-2002 unit prefixes for sizes.    
> > 
> > Does ePAPR recommend this?  
> 
> Not directly, but the paper (v1.1) itself is using MiB as well which
> could be seen as a recommendation.

Found the pdf again on the web, so here a link:
http://elinux.org/images/c/cf/Power_ePAPR_APPROVED_v1.1.pdf

Funny thing it's using KB(instead of KiB) and MiB. So it's
inconsistent, also the unit with SI prefix would be kB and not KB. So
I'd say ePAPR doesn't care / the authors didn't pay any attention to
this.

Ralph
