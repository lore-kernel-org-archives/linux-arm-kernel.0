From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 13 Mar 2012 15:08:22 +0100
Subject: [PATCH 1/5 v4] i2c/gpio: add DT support
In-Reply-To: <1331642024-19869-1-git-send-email-plagnioj@jcrosoft.com>
References: <1331642024-19869-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20120313140822.GD2488@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 01:33:40PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:

> update to use devm_kzalloc for private data

Hmm, you need really to work on the commit messages, not everybody is
familiar with DT and its implications:

"To achieve DT support, we need to populate a custom platform_data in a
private struct from DT information. To simplify code, the adapter and
algorithm are also put into the private struct."

Something like this?

> ---
> v4:
> 
> 	fix timeout

You need to work on the changelogs as well :)

> 	use gpio_is_valid

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120313/913aa960/attachment.sig>
