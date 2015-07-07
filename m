From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jul 2015 14:53:17 +0100
Subject: [RESEND 08/10] regulator: pwm-regulator: Add support for
 continuous-voltage
In-Reply-To: <20150707134545.GH3182@x1>
References: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
 <1436173112-21397-9-git-send-email-lee.jones@linaro.org>
 <20150707133155.GL2887@sirena.org.uk> <20150707134545.GH3182@x1>
Message-ID: <20150707135317.GR2887@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 02:45:45PM +0100, Lee Jones wrote:
> On Tue, 07 Jul 2015, Mark Brown wrote:
> > On Mon, Jul 06, 2015 at 09:58:30AM +0100, Lee Jones wrote:

> > > +	tmp = max_duty_cycle - min_mV * max_duty_cycle / vdiff;
> > > +	pwm_code = tmp + max_duty_cycle * volt_mV / vdiff;

> > These need some brackets to be clear that they're correct.

> As you rightly pointed out, this stuff gets over-written in the next
> patch, although I have no problem with providing some bracketing if
> required.

Yes, please.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150707/1a0c77cd/attachment.sig>
