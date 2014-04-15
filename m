From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 15 Apr 2014 22:54:37 +0200
Subject: [PATCH 0/3] net: mvneta: fix usage as a module,
 and support QSGMII properly
In-Reply-To: <1397569821-5530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Tue, 15 Apr 2014 15:50:18 +0200")
References: <1397569821-5530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87a9bmxqia.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:

> This set of patches has been tested on:
>
>  * Armada XP GP (four QSGMII interfaces)
>  * Armada XP DB (two RGMII interfaces and two SGMII interfaces)
>  * Armada 370 Mirabox (two RGMII interfaces)
>
> I've tested both the driver built-in, and compiled as a module.
>
> Since the last attempt at fixing this was quite a fiasco, I'd like
> this new attempt to be tested more widely before being applied. I'll
> try to do some testing on other Armada boards I have, but independent
> testing from other persons would also be appreciated.
>
> Note that these patches apply after reverting the previous attempt,
> obviously.

I just tested the set w/ the driver built-on on top of current
3.15.0-rc1 w/ e3a8786c10e7 reverted on a RN102 (A370, 2xRGMII), a
RN104  (A370, 2xRGMII) and a RN2120 (AXP, 2xRGMII). The interface(s)
work(s) as expected, i.e. everything is in order. You can add my

Tested-by: Arnaud Ebalard <arno@natisbad.org>

Thanks for your work!

Cheers,

a+
