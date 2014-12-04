From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Dec 2014 17:08:13 +0100
Subject: [PATCH] arm: ep93xx: add dma_masks for the M2P and M2M DMA
 controllers
In-Reply-To: <DC148C5AA1CEBA4E87973D432B1C2D8826070BCE@P3PWEX4MB008.ex4.secureserver.net>
References: <1416590622-7765-1-git-send-email-hsweeten@visionengravers.com>
 <4031997.JKQRhrzkna@wuerfel>
 <DC148C5AA1CEBA4E87973D432B1C2D8826070BCE@P3PWEX4MB008.ex4.secureserver.net>
Message-ID: <8117546.fJoYSDGdY9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 December 2014 21:14:36 Hartley Sweeten wrote:
> On Monday, December 01, 2014 10:59 AM, Arnd Bergmann wrote:
> > Is there any harm in applying the fix on older kernels? If not, I'd just
> > mark it as stable for 3.11, which will cause it to get backported to
> > 3.17, 3.14 and 3.12 but not 3.10 or older longerm releases.
> 
> I don't see any harm with it. It just adds the dma_mask data that
> should have been there anyway.
> 

Ok, I've applied it to the fixes branch now as a reminder, with the

Cc: <stable@vger.kernel.org> # v3.11+

line added. It's already in next/fixes-non-critical, so the patch will
make it into 3.19, but if this is the only patch left for 3.18, we probably
won't send it. If not, I'll send an email to the stable list so it gets
backported.

I just noticed that we didn't have arm at kernel.org on Cc and you had just
sent the patch to me personally. To ensure that something gets picked up,
please send it to the arm at kernel.org alias so it doesn't accidentally get
lost, thanks!

	Arnd
