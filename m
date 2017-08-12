From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 12 Aug 2017 16:44:11 +0200
Subject: [PATCH v2 2/2] i2c: mediatek: Add i2c compatible for MediaTek
 MT7622
In-Reply-To: <1502506672-7620-3-git-send-email-jun.gao@mediatek.com>
References: <1502506672-7620-1-git-send-email-jun.gao@mediatek.com>
 <1502506672-7620-3-git-send-email-jun.gao@mediatek.com>
Message-ID: <20170812144411.zqgbncsemzaolldv@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +static const struct i2c_adapter_quirks mt7622_i2c_quirks = {
> +	.max_num_msgs = 255,
> +	.max_write_len = 65535,
> +	.max_read_len = 65535,
> +	.max_comb_1st_msg_len = 65535,
> +	.max_comb_2nd_msg_len = 65535,
> +};

That looks like no quirks? Then just leave the quirks pointer below
empty.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170812/1a522185/attachment.sig>
