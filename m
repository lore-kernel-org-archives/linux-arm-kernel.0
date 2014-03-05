From: broonie@kernel.org (Mark Brown)
Date: Wed, 5 Mar 2014 12:28:35 +0800
Subject: [PATCH v2 05/11] ARM: s3c64xx: pm: Add always_on field to
 s3c64xx_pm_domain struct
In-Reply-To: <1393862536-9842-6-git-send-email-tomasz.figa@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
 <1393862536-9842-6-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20140305042835.GG13126@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 05:02:10PM +0100, Tomasz Figa wrote:
> This patch adds always_on field to s3c64xx_pm_domain struct to allow
> handling registration of all domains in the same way, without the need
> to have separate arrays for normal and always on domains.

Reviwed-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140305/67347281/attachment-0001.sig>
