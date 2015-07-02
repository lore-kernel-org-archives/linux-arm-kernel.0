From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 2 Jul 2015 10:17:00 +0300
Subject: [RFC PATCH 00/15] pwm: add support for atomic update
In-Reply-To: <20150702070343.GD11824@pengutronix.de>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150702070343.GD11824@pengutronix.de>
Message-ID: <5594E56C.3010908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/07/15 10:03, Uwe Kleine-K?nig wrote:
> Hello Boris,
> 
> On Wed, Jul 01, 2015 at 10:21:46AM +0200, Boris Brezillon wrote:
>> This series adds support for atomic PWM update, or ITO, the capability
>> to update all the parameters of a PWM device (enabled/disabled, period,
>> duty and polarity) in one go.
> on first reading the subject of your series I thought it was about
> asserting that the newly set config is active before the call to
> pwm_config (et al) returns. That's a problem I addressed a few times in
> the past. I wonder if it's only me or if a different wording should be
> used for "update all parameters with a single function call".

In my vocabulary "blocking" means that the work is done before the
function returns, and "atomic" means the work is done in one step.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150702/6327f9f4/attachment.sig>
