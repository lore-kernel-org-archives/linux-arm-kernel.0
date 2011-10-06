From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 06 Oct 2011 19:53:04 +0200
Subject: [PATCH 2/2] hw_random: add driver for atmel true hardware random
	number generator
In-Reply-To: <20111006160200.GF1931@totoro> (Jamie Iles's message of "Thu, 6
	Oct 2011 17:02:00 +0100")
References: <1317915694-27564-1-git-send-email-jacmet@sunsite.dk>
	<1317915694-27564-2-git-send-email-jacmet@sunsite.dk>
	<20111006160200.GF1931@totoro>
Message-ID: <871uuq3t33.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Jamie" == Jamie Iles <jamie@jamieiles.com> writes:

 Jamie> Hi Peter,
 Jamie> A couple of minor nits inline, but otherwise looks nice to me!

Thanks for the review.

 Jamie> Could you do:

 Jamie> struct atmel_trng {
 Jamie> 	struct clk *clk;
 Jamie> 	void __iomem *base;
 Jamie> 	struct hwrng rng;
 Jamie> };

Sure. Multiple trngs doesn't make much sense, but that approach leads to
slightly less lines, so ok.

I'll send an updated patch shortly.

-- 
Bye, Peter Korsgaard
