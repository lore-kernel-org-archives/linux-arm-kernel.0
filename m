From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Mar 2015 10:05:36 +0100
Subject: [PATCH V4 4/4] mmc: pwrseq_simple: Add support for a reset GPIO
 pin
In-Reply-To: <CAPDyKFonXw2NDbEw9CoRj7Sncgm_FUki+cc7j3q=xVZRrJHBkg@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
 <1421658784-11980-5-git-send-email-ulf.hansson@linaro.org>
 <CAAVeFuJjU-fsknYdMZ1c+aOEmc2rFy=z35S584DfHBLvUm=OAQ@mail.gmail.com>
 <CAPDyKFonXw2NDbEw9CoRj7Sncgm_FUki+cc7j3q=xVZRrJHBkg@mail.gmail.com>
Message-ID: <CACRpkdabrcQu3xtzGrWhBfkPuMdFutFh790eGpxjbKtw8ObVRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 5:34 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 10 February 2015 at 10:12, Alexandre Courbot <gnurou@gmail.com> wrote:

>> This code would be a great candidate to use this GPIO array API, but
>> since it is not in -next yet (should happen soon though) you might
>> want to consider doing it later.

This is now in my git and -next, I can take patches to pwrseq if Ulf
ACKs them to go through my GPIO tree.

Yours,
Linus Walleij
