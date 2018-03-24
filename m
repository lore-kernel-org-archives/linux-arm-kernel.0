From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 24 Mar 2018 13:38:14 +0100
Subject: [PATCH v2] i2c: i2c-stm32f7: fix no check on returned setup
In-Reply-To: <1521650920-11578-1-git-send-email-pierre-yves.mordret@st.com>
References: <1521650920-11578-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20180324123814.xgwgtvq57d4whd6c@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 05:48:40PM +0100, Pierre-Yves MORDRET wrote:
> Before assigning returned setup structure check if not null
> 
> Fixes: 463a9215f3ca7600b5ff ("i2c: stm32f7: fix setup structure")
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180324/4e1aac23/attachment.sig>
