From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 24 Mar 2018 23:57:30 +0100
Subject: [PATCH v2 0/6] Add different features for I2C
In-Reply-To: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20180324225730.drpjbvr7nl7yol5q@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 05:48:54PM +0100, Pierre-Yves MORDRET wrote:
> Append new I2C STM32F7 feature set. This includes 10 bit support, slave
> support, SMBBus protocols support, DMA Support and eventually an I2C recovery
> mechanism.

So, I gave a few comments. For hardware details (especially DMA), some
additional review from Maxime or Alexandre would be great.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180324/0b32fd88/attachment-0001.sig>
