From: broonie@kernel.org (Mark Brown)
Date: Fri, 24 Jul 2015 11:32:47 +0100
Subject: [PATCHv2 0/3] regmap: Use different lockdep class for each
 regmap init call
In-Reply-To: <CANMq1KD8rOHjtWA1Eiw9GATdTeq1Ch4bga4ZAty26auvWyX7Og@mail.gmail.com>
References: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
 <CANMq1KD8rOHjtWA1Eiw9GATdTeq1Ch4bga4ZAty26auvWyX7Og@mail.gmail.com>
Message-ID: <20150724103247.GG11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 23, 2015 at 04:45:53PM +0800, Nicolas Boichat wrote:

> What's the status of this series (and the additional documentation
> fix: https://lkml.org/lkml/2015/7/8/385)?

> Do we need acks from the mfd/vexpress and thermal maintainers?
> (mfd/vexpress maintainers are Liviu Dudau, Sudeep Holla, and Lorenzo
> Pieralisi, I'm less clear about thermal, maybe Eduardo Valentin?)

Well, I was leaving it on the off chance someone would get round to
looking at it yes.  I might get bored at some point since it's just
mechanical changes outside of regmap.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150724/de058bbe/attachment.sig>
