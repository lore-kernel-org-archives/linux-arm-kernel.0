From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 8 Jan 2014 16:22:24 +0100
Subject: [PATCH v5 2/4] ARM: mvebu: Add quirk for i2c for the OpenBlocks
 AX3-4 board
In-Reply-To: <1389193589-18485-3-git-send-email-gregory.clement@free-electrons.com>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <1389193589-18485-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140108152224.GC15182@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +		new_compat->name =  kstrdup("compatible", GFP_KERNEL);
> +		new_compat->length =  sizeof("marvell,mv78230-a0-i2c");
> +		new_compat->value =  kstrdup("marvell,mv78230-a0-i2c",
> +						GFP_KERNEL);
> +

Very minor again: Strange whitespacing after "="

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/e4f01007/attachment.sig>
