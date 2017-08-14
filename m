From: jun.gao@mediatek.com (Jun Gao)
Date: Mon, 14 Aug 2017 09:36:56 +0800
Subject: [PATCH v2 2/2] i2c: mediatek: Add i2c compatible for MediaTek
 MT7622
In-Reply-To: <20170812144411.zqgbncsemzaolldv@ninjato>
References: <1502506672-7620-1-git-send-email-jun.gao@mediatek.com>
 <1502506672-7620-3-git-send-email-jun.gao@mediatek.com>
 <20170812144411.zqgbncsemzaolldv@ninjato>
Message-ID: <1502674616.930.74.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-08-12 at 16:44 +0200, Wolfram Sang wrote:
> > +static const struct i2c_adapter_quirks mt7622_i2c_quirks = {
> > +	.max_num_msgs = 255,
> > +	.max_write_len = 65535,
> > +	.max_read_len = 65535,
> > +	.max_comb_1st_msg_len = 65535,
> > +	.max_comb_2nd_msg_len = 65535,
> > +};
> 
> That looks like no quirks? Then just leave the quirks pointer below
> empty.
> 
Compare to MT8173 i2c controller, MT7622 limits message numbers to 255.

Jun
