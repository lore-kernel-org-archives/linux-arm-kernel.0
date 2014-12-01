From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Mon, 1 Dec 2014 21:14:36 +0000
Subject: [PATCH] arm: ep93xx: add dma_masks for the M2P and M2M DMA
 controllers
In-Reply-To: <4031997.JKQRhrzkna@wuerfel>
References: <1416590622-7765-1-git-send-email-hsweeten@visionengravers.com>
 <201411281235.50962.arnd@arndb.de>
 <DC148C5AA1CEBA4E87973D432B1C2D88260702F5@P3PWEX4MB008.ex4.secureserver.net>
 <4031997.JKQRhrzkna@wuerfel>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D8826070BCE@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 01, 2014 10:59 AM, Arnd Bergmann wrote:
> Is there any harm in applying the fix on older kernels? If not, I'd just
> mark it as stable for 3.11, which will cause it to get backported to
> 3.17, 3.14 and 3.12 but not 3.10 or older longerm releases.

I don't see any harm with it. It just adds the dma_mask data that
should have been there anyway.

Thanks,
Hartley
