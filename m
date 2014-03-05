From: broonie@kernel.org (Mark Brown)
Date: Wed, 5 Mar 2014 12:28:07 +0800
Subject: [PATCH v2 06/11] ARM: s3c64xx: pm: Add pwr_stat bit for domain G
In-Reply-To: <1393862536-9842-7-git-send-email-tomasz.figa@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
 <1393862536-9842-7-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20140305042807.GF13126@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 05:02:11PM +0100, Tomasz Figa wrote:
> There is a status bit for domain G present in BLK_PWR_STAT register, but
> it is currently not specified in the driver.
> 
> This patch adds the status bit of domain G to structure describing it.

Reviwed-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140305/1fd297b5/attachment.sig>
