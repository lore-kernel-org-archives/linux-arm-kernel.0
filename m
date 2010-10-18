From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Oct 2010 14:58:18 +0100
Subject: [PATCH 04/22] arm: introduce little endian bitops
In-Reply-To: <AANLkTi=1w9uV81CagrE53xEYkMaFh_3cM_+ybctT2ng4@mail.gmail.com>
References: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com>
	<1287135981-17604-5-git-send-email-akinobu.mita@gmail.com>
	<20101018092650.GC26183@n2100.arm.linux.org.uk>
	<AANLkTi=1w9uV81CagrE53xEYkMaFh_3cM_+ybctT2ng4@mail.gmail.com>
Message-ID: <20101018135818.GC12449@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 18, 2010 at 10:22:59PM +0900, Akinobu Mita wrote:
> 2010/10/18 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Fri, Oct 15, 2010 at 06:46:03PM +0900, Akinobu Mita wrote:
> >> Introduce little endian bit operations by renaming native ext2 bit
> >> operations. The ext2 bit operations are kept by using little endian
> >> bit operations until the conversions are finished.
> >
> > Can you explain why we need another level of indirection rather than
> > using asm-generic/bitops/le.h, asm-generic/bitops/minix.h and
> > asm-generic/bitops/ext2-non-atomic.h ?
> 
> Sorry for not CCing the cover letter of this patch series.

BTW, I've not seen any of the others in this patch series, not even via
linux-arch...
