From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Dec 2014 23:05:11 +0000
Subject: [PATCHv1 1/3] rtc: rtc-isl12057: add alarm support to Intersil
 ISL12057 RTC driver
In-Reply-To: <5490A873.1000706@kleine-koenig.org>
References: <cover.1418687005.git.arno@natisbad.org>
 <db1f0eecbdc5062a61232b99699ecfa6e0a2a956.1418687005.git.arno@natisbad.org>
 <549004B9.2060402@kleine-koenig.org> <87vblbdcii.fsf@natisbad.org>
 <5490A873.1000706@kleine-koenig.org>
Message-ID: <20141216230511.GV11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 10:47:31PM +0100, Uwe Kleine-K?nig wrote:
> On 12/16/2014 01:07 PM, Arnaud Ebalard wrote:

> > no, it is for this patch. I did a specific commit message for the second
> > patch. IIRC, it also has the example if it was the meaning of your
> > question.

> Is it usual that an rtc can wake up a machine from shutdown state? I
> thought it isn't.

It's fairly normal when the RTC is integrated into the PMIC - the PMIC
is typically the component initiating power on so it's easy for it to do
so.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141216/497941e6/attachment.sig>
