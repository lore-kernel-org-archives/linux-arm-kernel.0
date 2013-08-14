From: olof@lixom.net (Olof Johansson)
Date: Wed, 14 Aug 2013 09:25:02 -0700
Subject: [PATCH v6 2/4] ARM: debug: support debug ll on hisilicon soc
In-Reply-To: <20130814154443.GV23006@n2100.arm.linux.org.uk>
References: <1374813135-16238-1-git-send-email-haojian.zhuang@linaro.org>
 <1374813135-16238-3-git-send-email-haojian.zhuang@linaro.org>
 <20130814063916.GH19951@quad.lixom.net>
 <20130814154443.GV23006@n2100.arm.linux.org.uk>
Message-ID: <20130814162502.GA16491@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 04:44:44PM +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 13, 2013 at 11:39:16PM -0700, Olof Johansson wrote:
> > On Fri, Jul 26, 2013 at 12:32:13PM +0800, Haojian Zhuang wrote:
> > > Support UART0 debug ll on hisilicon Hi3620 SoC.
> > > 
> > > Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> > 
> > 
> > Applied, thanks.
> 
> Applied without reference to my debug cleanup series which has been
> sitting in linux-next for ages?
> 
> Whatever happened to encouraging people to do things in a manner
> compatible with the cleanups we're trying to do?

I quite frankly forgot that this was pending for 3.12 in your tree.

Thanks for catching this, I'll revert the patch in arm-soc and let it go
in through yours on top of your cleanups.


-Olof
