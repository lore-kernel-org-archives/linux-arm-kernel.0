From: tony@bakeyournoodle.com (Tony Breeds)
Date: Sat, 6 Nov 2010 12:36:36 +1100
Subject: [PATCH] ARM: fix build error with GCC 4.5.0
In-Reply-To: <19668.21026.5416.610777@pilspetsen.it.uu.se>
References: <1288897002-24073-1-git-send-email-rabin@rab.in>
	<yw1xy698ygbx.fsf@unicorn.mansr.com>
	<19667.9199.798932.405415@pilspetsen.it.uu.se>
	<AANLkTinUcS3v57bMLXcHaqC+OGoAqgoK2td-ce3B6FOM@mail.gmail.com>
	<19667.52998.909668.596635@pilspetsen.it.uu.se>
	<AANLkTimkSxWNL+aCALGsf5prBM_RHz0BMHCeNwKrTnfA@mail.gmail.com>
	<19668.21026.5416.610777@pilspetsen.it.uu.se>
Message-ID: <20101106013636.GM24185@ozlabs.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 05, 2010 at 07:51:14PM +0100, Mikael Pettersson wrote:

> That's an OABI compiler. You want a compiler configured for
> 
> 	--target=arm-unknown-linux-gnueabi
> 
> and without that --enable-sjlj-exceptions as well.
> 
> OABI is super-legacy and essentially unsupported by current gcc.

Thanks.  I'll fix that when I re-spin for gcc-4.5.1 (hopefully late next week.

Yours Tony
