From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 May 2012 17:38:32 +0100
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <4FAD3EF3.4080409@ti.com>
References: <4FAAC549.6010206@ti.com> <4FAAE564.6040708@ti.com>
 <20120510084422.GB27276@mudshark.cambridge.arm.com>
 <4FAC0F05.3060803@ti.com>
 <20120511122547.GE17453@mudshark.cambridge.arm.com>
 <4FAD1865.70003@ti.com>
 <20120511134920.GC2626@mudshark.cambridge.arm.com>
 <4FAD27CB.5060102@ti.com>
 <20120511150223.GD2626@mudshark.cambridge.arm.com>
 <4FAD3EF3.4080409@ti.com>
Message-ID: <20120511163831.GI2626@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 05:31:47PM +0100, Jon Hunter wrote:
> Can you send me your .config?

Sent off-list.

> At the same time, maybe just try "make omap2plus_defconfig" and enable
> the OMAP3 debug devices config. That's all I am doing.

Excellent, that works for me. Once we've worked out the problem with my
.config you can have my tested-by.

Cheers,

Will
