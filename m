From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Mon, 22 May 2017 20:24:16 +0200
Subject: [PATCH 08/13] ARM: dts: armada-385-linksys: use binary unit
 prefixes
In-Reply-To: <20170522150001.GM29447@lunn.ch>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
 <20170521124903.11050-9-ralph.sennhauser@gmail.com>
 <20170522150001.GM29447@lunn.ch>
Message-ID: <20170522202416.1c48d91a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 May 2017 17:00:01 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Sun, May 21, 2017 at 02:48:57PM +0200, Ralph Sennhauser wrote:
> > Use IEEE 1541-2002 unit prefixes for sizes.  
> 
> Does ePAPR recommend this?

Not directly, but the paper (v1.1) itself is using MiB as well which
could be seen as a recommendation.

SI and NIST to my knowledge explicitly state to not use SI prefixes for
anything but powers of 10. Also as far as I'm aware any relevant
standard body adopted / endorsed these.

> 
> I think this looks ugly, so i would not do it.

Needs getting used to indeed. I for myself I can say I've gotten over
it by now. Grepping the Linux tree shows quite a few other examples of
MiB so this one wont feel lonely either.

Ralph
