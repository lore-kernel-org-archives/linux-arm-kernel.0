From: horms@verge.net.au (Simon Horman)
Date: Wed, 8 Jan 2014 09:41:57 +0900
Subject: [PATCH 04/04 v2] ARM: shmobile: Genmai I2C-over-GPIO support
In-Reply-To: <20131217163435.GC7071@katana>
References: <20131217050232.727.9552.sendpatchset@w520>
 <20131217050324.727.61701.sendpatchset@w520>
 <20131217163435.GC7071@katana>
Message-ID: <20140108004157.GH5136@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 05:34:36PM +0100, Wolfram Sang wrote:
> On Tue, Dec 17, 2013 at 02:03:24PM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Add support for the Genmai I2C bus hooked up to P1_5 and P1_4 using
> > the i2c-gpio driver. On the bus sits a 24c128 EEPRROM.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

Hi Magnus, Hi Wolfram,

could you clarify the status of this patch for me?

I believe it is reverted by "[PATCH V2 4/5] arm: shmobile: genmai: adapt
dts to use native i2c driver".

I'm fine with applying both patches at some point. But perhaps
we can skip some dependencies by just applying a squashed version?
