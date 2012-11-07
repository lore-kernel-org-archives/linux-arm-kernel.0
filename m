From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 7 Nov 2012 10:04:16 +0100
Subject: [Resend PATCH v3 2/4] ARM: at91: atmel-ssc: add device tree
 support
In-Reply-To: <20121107084733.GD20063@game.jcrosoft.org>
References: <1352259701-19847-1-git-send-email-voice.shen@atmel.com>
 <20121107082419.GB12323@opensource.wolfsonmicro.com>
 <20121107084733.GD20063@game.jcrosoft.org>
Message-ID: <20121107090416.GD12323@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 09:47:33AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:

> Mark I nack the patch series this patch series does not run on any DT kernel

> as no picntrl is done

> do not apply until this patfh handle the pinctrl

Nicholas seemed to be disagreeing you on that one and his observation
that it won't be an issue until v3.8 anyway seemed totally reasonable.
In any case it doesn't seems like it'll be an issue to get it resolved
before it actually gets merged down to become an issue.

Of course there's also some ongoing discussion on the question of having
to add mindless pinctrl_get_set_default() to all the drivers at all, the
fact that we're having to do that at all seems like a failure to me at
least.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121107/2ee5157c/attachment.sig>
