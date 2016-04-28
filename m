From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 28 Apr 2016 16:57:20 +0200
Subject: [PATCH] i2c: st: Implement i2c_bus_recovery_info callbacks
In-Reply-To: <5722107C.3000600@st.com>
References: <1460467759-11737-1-git-send-email-peter.griffin@linaro.org>
 <20160424211044.GD4317@katana> <5722107C.3000600@st.com>
Message-ID: <20160428145720.GA1541@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> The trick is to switch to SPI mode, 9 bits words and write a 0,
> so that 9 clock pulses are generated.

Heh. As long as it works :) But as you said, it really needs a comment.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160428/f5187d0c/attachment.sig>
