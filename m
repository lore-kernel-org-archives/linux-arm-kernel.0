From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Dec 2011 10:13:13 -0800
Subject: [GIT PULL] ARM: OMAP: device PM constraints: preparatory support
In-Reply-To: <alpine.DEB.2.00.1112201251010.12660@utopia.booyaka.com>
References: <alpine.DEB.2.00.1112201251010.12660@utopia.booyaka.com>
Message-ID: <20111222181313.GL24444@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111220 11:21]:
> Hi Tony
> 
> These patches prepare for the introduction of the powerdomain device PM 
> constraints, via the standard Linux device PM mechanism that Rafael 
> Wysocki introduced.
> 
> After the powerdomain device PM constraints go in, we should be able to 
> remove some of the OMAP PM interface (currently via platform_data function 
> pointers) currently in our tree.

Thanks pulling these into hwmod-part2, no idea if we can still get
these in as it's so close to the merge window.

Regards,

Tony
