From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 22 May 2014 14:09:52 -0400 (EDT)
Subject: [PATCH v2] ARM: realview: basic device tree implementation
In-Reply-To: <5057707.jNCXlqf9dH@wuerfel>
References: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
 <5678119.IM3FN0FlT6@wuerfel> <20140522144503.GA27931@arm.com>
 <5057707.jNCXlqf9dH@wuerfel>
Message-ID: <alpine.LFD.2.11.1405221406100.17310@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 May 2014, Arnd Bergmann wrote:

> On Thursday 22 May 2014 15:45:03 Catalin Marinas wrote:
> > By making the DMA memory Strongly Ordered, we avoid the
> > L220 write buffer. In addition to the above commit, we also had
> > 2503a5ecd86c (ARM: 6201/1: RealView: Do not use outer_sync() on
> > ARM11MPCore boards with L220).
> 
> Ah, so this also stands in the way of multiplatform realview :(

Isn't the real value of a multiplatform realview in the ability to use 
it with Qemu?  Did Qemu go to the extreme of emulating all those cache 
issues?


Nicolas
