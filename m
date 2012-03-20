From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 20 Mar 2012 06:59:30 +0100
Subject: [PATCH v4 01/10] PWM: add pwm framework support
In-Reply-To: <4F67E38F.6080300@wwwdotorg.org>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-2-git-send-email-thierry.reding@avionic-design.de>
 <4F67E38F.6080300@wwwdotorg.org>
Message-ID: <20120320055930.GB25778@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> On 03/14/2012 09:56 AM, Thierry Reding wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > This patch adds framework support for PWM (pulse width modulation) devices.
> ...
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> ...
> > +/**
> > + * pwmchip_add() - register a new pwm
> > + * @chip: the pwm
> > + *
> > + * register a new pwm. pwm->pwm_id must be initialized. if pwm_id < 0 then
> > + * a dynamically assigned id will be used, otherwise the id specified,
> > + */
> 
> I don't see anywhere in the code that implements "if pwm_id < 0 then a
> dynamically assigned id will be used".

The second patch in the series fixes up this comment when the functionality
is properly implemented. I still wanted to go over the first patch and fix up
some minor things, so maybe I'll fix this up as I go along.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120320/f86a1fb5/attachment.sig>
