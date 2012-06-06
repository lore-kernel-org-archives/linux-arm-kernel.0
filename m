From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 06 Jun 2012 11:42:48 +0300
Subject: [PATCH v5] MTD: LPC32xx SLC NAND driver
In-Reply-To: <1338837901-24075-1-git-send-email-stigge@antcom.de>
References: <1338837901-24075-1-git-send-email-stigge@antcom.de>
Message-ID: <1338972168.6875.7.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-06-04 at 21:25 +0200, Roland Stigge wrote:
> +config MTD_NAND_SLC_LPC32XX
> +	bool "NXP LPC32xx SLC Controller"

Why bool and not tristate here? Why you force this to be compiled-in and
make it impossible to be a kernel module like other drivers are?

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120606/b4a9e1ee/attachment.sig>
