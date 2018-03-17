From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 17 Mar 2018 21:44:18 +0100
Subject: [RESEND PATCH v1] i2c: i2c-stm32f7: fix no check on returned setup
In-Reply-To: <1520859201-30549-1-git-send-email-pierre-yves.mordret@st.com>
References: <1520859201-30549-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20180317204417.xwfl32lr7zt3dy25@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 01:53:21PM +0100, Pierre-Yves MORDRET wrote:
> Before assigning returned setup structure check if not null
> 
> Fixes: 463a9215f3ca7600b5ff ("i2c: stm32f7: fix setup structure")
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Maxime? Alexandre?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180317/1b341a5a/attachment.sig>
