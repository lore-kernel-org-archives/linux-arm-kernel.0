From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 26 Nov 2014 11:46:27 -0800
Subject: [PATCHv1 0/6] rtc: rtc-isl12057: fixes and alarm support
In-Reply-To: <54762096.7040200@kleine-koenig.org>
References: <cover.1416006090.git.arno@natisbad.org>
 <874mtlyflf.fsf@natisbad.org> <54762096.7040200@kleine-koenig.org>
Message-ID: <20141126114627.9c29947c6f524b0dd9883c15@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Nov 2014 19:48:54 +0100 Uwe Kleine-K__nig <uwe@kleine-koenig.org> wrote:

> Hello Arnaud,
> 
> On 11/26/2014 07:35 PM, Arnaud Ebalard wrote:
> > I wonder if you could take a look at this series I sent providing fixes
> > (patches #1-5) and alarm support (patch #6) for ISL12057 RTC Chip. As
> > all people do for RTC patches - due to lack of feedback from maintainer
> > - I am looking for someone to review the patches (Mark, patch 6 has a
> > sticker w/ regmap-inside ;-)) and then push those upstream if they are
> > ok (Jason, you handled that part for 70e123373c05: "rtc: Add support for
> > Intersil ISL12057 I2C RTC chip" in 2013 for the same reason).
> > 
> > Note that I addressed previous comments and feedback received from Uwe
> > and also spent time to do some soldering in order to support and test
> > the last patch for both my use case (Alarm IRQ signal not routed to the
> > SoC on ReadyNAS RN102, RN104 and RN2120) and the common case.
> > 
> > Do not hesitate to ask if you want me to resend!
> akpm already applied the series, doesn't he?
> 
> I'm about to test the patches, just fighting with my NAS to boot my
> custom kernel.
> 
> Apart from that patches 1 - 5 can have my Ack. Didn't look deep enough
> into patch 6 yet. @akpm: No need to hurry adding them, I hope to be
> able to also provide Tested-by:-tags later today.

Thanks, it really helps.
