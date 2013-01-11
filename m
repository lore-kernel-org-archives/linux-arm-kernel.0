From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 11 Jan 2013 09:38:00 -0800
Subject: [PATCH 0/3] arch_decomp_wdog cleanup
In-Reply-To: <20130111170843.GG23505@n2100.arm.linux.org.uk>
References: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
 <20130111170843.GG23505@n2100.arm.linux.org.uk>
Message-ID: <054001cdf022$694200e0$3bc602a0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Thu, Jan 10, 2013 at 10:12:42PM +0800, Shawn Guo wrote:
> > All the arch_decomp_wdog related codes are there without any users,
> > since ARCH_HAS_DECOMP_WDOG is only used by lib/inflate.c which
> however
> > is not used by arch/arm/boot/compressed/decompress.c.
> 
> Hmm, this suggests that those samsung platforms haven't been booted for
> a while - because the decompressor will enable the watchdog, but won't
> pat it at all.  So, do we still need them in the kernel?
> 
Hmm, I didn't see its usage lately on relatively Samsun SoCs. But let me
check again, the code is not used on every Samsung SoCs. So please hold on a
couple of days, I already reply 'ack' on Samsung stuff though.

Thanks.

- Kukjin
