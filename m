From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 7 Nov 2012 10:21:24 +0100
Subject: [Resend PATCH v3 2/4] ARM: at91: atmel-ssc: add device tree
 support
In-Reply-To: <20121107084932.GE20063@game.jcrosoft.org>
References: <1352259701-19847-1-git-send-email-voice.shen@atmel.com>
 <20121107084932.GE20063@game.jcrosoft.org>
Message-ID: <20121107092124.GE12323@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 09:49:32AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:

> yes the pinctrl is mainline in -next via pinctrl tree

> s code does not work on the DT kernel untill it's done

> NACK stand I refuse this touch the at91 dtsi untiol it's done correctly

...and here's another mail (plus a further private mail on the same
subject) by the time I managed to reply to the first one, the timestamps
say in about ten minutes :/  What I'm seeing here is two of the Atmel
maintainers disagreeing about a patch so I've got to pick one view and
right now applying the patch looks like it moves us further forwards.

Like I say it's not an issue right now and it seems like it should be
trivial to fix.  Is anything needed here other than adding the
pinctrl_get_set_default() call, in which case would it not be less
effort all round to just send the patch?  If there is more involved then
what is needed?

Thinking about it a little more I'm actually wondering why whatever
pinctrl change made this mandatory didn't go through and update all the
drivers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121107/953f097e/attachment.sig>
