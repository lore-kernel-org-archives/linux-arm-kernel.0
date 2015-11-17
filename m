From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Nov 2015 10:55:19 +0000
Subject: [PATCH] regulator: mt6311: MT6311_REGULATOR needs to select
 REGMAP_I2C
In-Reply-To: <564AFCC8.6000604@gmail.com>
References: <1447749409-19900-1-git-send-email-henryc.chen@mediatek.com>
 <564AFCC8.6000604@gmail.com>
Message-ID: <20151117105519.GN31303@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 11:09:12AM +0100, Matthias Brugger wrote:

> This should also be added to v4.3
> I propose that you resend it adding the tag:
> Cc: stable at vger.kernel.org

> as explained in Documentation/stable_kernel_rules.txt

Please don't, that just makes more work for me having to deal with two
copies of the mail.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151117/0bcdbd62/attachment.sig>
