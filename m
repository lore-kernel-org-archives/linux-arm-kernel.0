From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 9 Aug 2012 17:51:45 +0100
Subject: [PATCH 1/2] ARM: build ssi-fiq.S in ARM mode to prevent
 CONFIG_THUMB2_KERNEL build breakage
In-Reply-To: <CAKGA1bkzOEiMm8Uo=AiXdquhKHFhjgHE0qXaztcxRvMDSjkfaQ@mail.gmail.com>
References: <1344379514-30076-1-git-send-email-matt@genesi-usa.com>
 <1344379514-30076-2-git-send-email-matt@genesi-usa.com>
 <20120808065502.GI1451@pengutronix.de>
 <CAKGA1bmUuSZuWDM4QPTxmNR0+=uQ1RbFhw4u-sb9KaSPYwQiVw@mail.gmail.com>
 <20120809102414.GA17588@linaro.org>
 <CAKGA1bniQK9DbZudrHk1mA7FyDZkQzBJbWNUFTFW3pc_2A2x4g@mail.gmail.com>
 <20120809145005.GB17588@linaro.org>
 <CAKGA1bkzOEiMm8Uo=AiXdquhKHFhjgHE0qXaztcxRvMDSjkfaQ@mail.gmail.com>
Message-ID: <20120809165145.GD17588@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 11:05:47AM -0500, Matt Sealey wrote:
> On Thu, Aug 9, 2012 at 9:50 AM, Dave Martin <dave.martin@linaro.org> wrote:
> > On Thu, Aug 09, 2012 at 09:32:59AM -0500, Matt Sealey wrote:
> >> Matt Sealey <matt@genesi-usa.com>
> >> Product Development Analyst, Genesi USA, Inc.
> >>
> >>
> >> On Thu, Aug 9, 2012 at 5:24 AM, Dave Martin <dave.martin@linaro.org> wrote:
> >> > On Wed, Aug 08, 2012 at 12:32:39PM -0500, Matt Sealey wrote:
> >> >
> >> > [...]
> >> >
> >> >> I'm going to do a trapse through and find where Russell nacked Dave's
> >> >> thumb-aware
> >> >> rewrite.. would you mind if you have any of these boards seeing if it
> >> >> really DOES
> >> >
> >> > There was no NAK because I didn't get as far as posting the patch,
> >>
> >> http://lists.arm.linux.org.uk/lurker/message/20111202.133911.393b6e28.en.html
> >>
> >> You did, twice :)
> >
> > Well, I meant that I had not posted it as a stand-alone patch for
> > inclusion; I only posted it when commenting on other threads.
> >
> >> > mostly because of the doubt about whether this code is ever relevant
> >> > on Thumb2-capable hardware.
> >>
> >> It's not, but it does break the build, and without disabling phyCORE boards for
> >> Thumb2 it will always break the build..
> >
> > If you want me to push it, let me know.  I don't think this should get
> > merged without some Tested-bys for hardware where the FIQ stuff actually
> > gets used.
> 
> Please, then all the Tested-by's should flood in, right? :)

Do you have any suggestions for who I should CC to speed things up?

Cheers
---Dave
