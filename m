From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 24 Mar 2018 23:51:38 +0100
Subject: [PATCH v2 4/6] i2c: i2c-stm32: Add generic DMA API
In-Reply-To: <1521650940-11651-5-git-send-email-pierre-yves.mordret@st.com>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-5-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20180324225138.d5yipagxiouoyqtl@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 05:48:58PM +0100, Pierre-Yves MORDRET wrote:
> This patch adds a generic DMA API to implement DMA support for i2c-stm32fx
> drivers
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

In case you haven't read it so far, there is a new document about I2C &
DMA -> Documentation/i2c/DMA-considerations

Just so you know...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180324/bf46a4ae/attachment-0001.sig>
