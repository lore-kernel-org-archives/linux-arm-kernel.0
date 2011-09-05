From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 5 Sep 2011 17:08:03 +0100
Subject: A question about the abbreviation of the Cache Size Selection
	Register
In-Reply-To: <CADrkgW+UunPGqfmUdNUxjxiWJzv93JSMjn0g8o=AM_Con6S4gg@mail.gmail.com>
References: <CADrkgW+UunPGqfmUdNUxjxiWJzv93JSMjn0g8o=AM_Con6S4gg@mail.gmail.com>
Message-ID: <20110905160803.GH3269@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 04, 2011 at 07:52:51PM +0100, IL HAN wrote:
> arch/arm/boot/compressed/head.S
> mcr p15, 2, r10, c0, c0, 0  @ select current cache level in cssr
>  
> In the comment, It says cssr as the Cache Size Selection Register.
> But, according to the ARM Architecture Manuals, the abbreviation of the Cache
> Size Selection Register is CSSELR.
> That's confusing.
> Actually, both of abbreviations are used officially?

The official name is CSSELR. The CSSR name may have been present is some
draft revisions of the documentation and they made their way into the
mainline kernel. I'm not to bothered about this but feel free to send a
patch if you want the correct names.

-- 
Catalin
