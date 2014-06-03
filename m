From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 3 Jun 2014 16:02:39 +0800
Subject: [PATCH 1/5] ARM: berlin: add SMP support
In-Reply-To: <20140603075011.GA22742@lunn.ch>
References: <1401700866-24804-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401700866-24804-2-git-send-email-antoine.tenart@free-electrons.com>
 <20140602094715.GG28090@lunn.ch> <20140602100048.GA12162@kwain>
 <20140602100332.GH28090@lunn.ch> <20140602102750.GB13681@kwain>
 <20140603141913.710a1f7e@xhacker> <20140603075011.GA22742@lunn.ch>
Message-ID: <20140603160239.38defafe@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Tue, 3 Jun 2014 00:50:11 -0700
Andrew Lunn <andrew@lunn.ch> wrote:

> > We don't support independently power off cpu on BG2 and BG2Q in linux
> > kernel. So we can assume that bootloader has powered on the CPUs
> 
> Can i assume from your answer that the hardware does actually support
> independent power off/on of CPUs? It could be added sometime in the
> future.
> 

The BG2 and BG2Q HW doesn't support independent power off/on CPUs.

Sorry for confusion,
Jisheng
