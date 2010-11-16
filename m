From: tony@bakeyournoodle.com (Tony Breeds)
Date: Tue, 16 Nov 2010 14:17:58 +1100
Subject: [PATCH] ARM: fix build error with GCC 4.5.0
In-Reply-To: <19676.63422.614246.989202@pilspetsen.it.uu.se>
References: <1288897002-24073-1-git-send-email-rabin@rab.in>
	<yw1xy698ygbx.fsf@unicorn.mansr.com>
	<19667.9199.798932.405415@pilspetsen.it.uu.se>
	<AANLkTinUcS3v57bMLXcHaqC+OGoAqgoK2td-ce3B6FOM@mail.gmail.com>
	<19667.52998.909668.596635@pilspetsen.it.uu.se>
	<AANLkTimkSxWNL+aCALGsf5prBM_RHz0BMHCeNwKrTnfA@mail.gmail.com>
	<19668.21026.5416.610777@pilspetsen.it.uu.se>
	<20101112044548.GA19615@ozlabs.org>
	<19676.63422.614246.989202@pilspetsen.it.uu.se>
Message-ID: <20101116031758.GB19615@ozlabs.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 12, 2010 at 09:15:58AM +0100, Mikael Pettersson wrote:

> Drop --with-system-libunwind.  OABI was sjlj while EABI uses an ARM EABI
> specific unwinder implemented in gcc.  This may or may not matter if you
> only want to compile the kernel.

I'm not building a libc so the kernel is pretty much all that will be
compilable with these compilers.
 
> The other options should be ok, though I personally wouldn't pass
> --disable-threads, --disable-decimal-float, or --disable-bootstrap.

They're used for other platforms as long as the don't hurt arm I'll leave them
there to keep the scripts simple.

Thanks for your time.  I hope to have the i386 and x86_64 gcc-4.4.5 tollchains
on kernel.org tomorrow. 4.5.1 shortly after that.

Yours Tony
