From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Sep 2010 22:31:13 +0100
Subject: [PATCH] ARM: abstract atags parsing
In-Reply-To: <alpine.LFD.2.00.1009231713570.13233@xanadu.home>
References: <alpine.LFD.2.00.1009231713570.13233@xanadu.home>
Message-ID: <20100923213113.GC26295@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 23, 2010 at 05:18:02PM -0400, Nicolas Pitre wrote:
> This code movement will make it cleaner and easier to introduce support 
> for device tree which is basically an alternative to atags. No functional
> changes are introduced by this patch.

I don't see any point to this churn.

DT has yet to be shown to be useful on anything but the ARM evaluation
boards, and that's one of the pre-conditions to it becoming acceptable
(which has been pending for a few years now.)
