From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Oct 2015 10:24:18 +0200
Subject: [PATCH v1 1/2] phy: keystone: serdes driver for gbe 10gbe and pcie
In-Reply-To: <56253B91.5040807@ti.com>
References: <1444919145-30845-1-git-send-email-w-kwok2@ti.com>
 <230CBA6E4B6B6B418E8730AC28E6FC7E04229363@DFLE11.ent.ti.com>
 <56253B91.5040807@ti.com>
Message-ID: <4661946.mPHVFLWuan@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 October 2015 14:50:57 Murali Karicheri wrote:
> Arnd, by your statement 'I don't see any code that does this' do you 
> expect a piece of code that embed the license in the binary image? If 
> so, that seems weired to me.
> 
> Many of the drivers including this patch has the following statement in 
> the license that is additional company specific license such as BSD that 
> is applicable.
> 
> ==== Cut and pasted from drivers/crypto/fcrypt.c =======================
>   * 2. Redistributions in binary form must reproduce the above copyright
>   *    notice, this list of conditions and the following disclaimer in the
>   *    documentation and/or other materials provided with the distribution.
> =========================================================================
> I read this as if the source is compiled and distributed as a binary 
> either a kernel module ko file or as part of the kernel binary, this 
> term must apply. Usually this is part of documentation that goes with 
> the product AFAIK.

Sorry, my fault. This is indeed the standard BSD license, and
I misread this as having to produce the copyright statement
from the binary itself. Please ignore whatever I said on the
subject.

	Arnd
