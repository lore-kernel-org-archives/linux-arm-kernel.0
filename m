From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 5 Feb 2014 10:08:18 +0100
Subject: [PATCH 1/6] i2c: bcm-kona: register with subsys_initcall
In-Reply-To: <1391516352-32359-2-git-send-email-mporter@linaro.org>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-2-git-send-email-mporter@linaro.org>
Message-ID: <20140205090818.GA2614@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 07:19:07AM -0500, Matt Porter wrote:

> Voltage regulators are needed very early due to deferred probe
> being incompatible with built-in USB gadget drivers.

What does it need to fix those instead?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140205/9c9b7759/attachment.sig>
