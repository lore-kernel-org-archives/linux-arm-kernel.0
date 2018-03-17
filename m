From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 17 Mar 2018 21:51:10 +0100
Subject: [RESEND PATCH v1 2/6] i2c: i2c-stm32f7: Add slave support
In-Reply-To: <1520852023-27083-3-git-send-email-pierre-yves.mordret@st.com>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-3-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20180317205109.gocf5wemtjkyomct@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> + * @master_mode: boolean to know in which mode the I2C is running (master or
> + * slave)

It can't do both at the same time?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180317/3a104d20/attachment.sig>
