From: tony@atomide.com (Tony Lindgren)
Date: Tue, 9 Oct 2012 12:02:52 -0700
Subject: [GIT PULL] ARM: OMAP: warnings/hwmod/clock fixes for pre-3.7-rc1
In-Reply-To: <alpine.DEB.2.00.1210091602390.5736@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210091602390.5736@utopia.booyaka.com>
Message-ID: <20121009190252.GD12552@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121009 09:05]:
> 
> N800 isn't booting; this is a problem present in the base commit and
> is due to serial driver breakage:
> 
>    http://www.spinics.net/lists/arm-kernel/msg196034.html

This might be related also to the n800 booting in sys mode
that causes issues with the recent hyp patches. A fix for
that has been queued, for more info see the thread
"v2 2/7] ARM: virt: allow the kernel to be entered in HYP mode".

Regards,

Tony
