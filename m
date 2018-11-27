From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 27 Nov 2018 13:10:34 +0100
Subject: [PATCH v2] i2c: i2c-stm32f7: add PM Runtime support
In-Reply-To: <1542625464-4704-1-git-send-email-pierre-yves.mordret@st.com>
References: <1542625464-4704-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20181127121034.GK1107@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 12:04:24PM +0100, Pierre-Yves MORDRET wrote:
> Use PM Runtime API to enable/disable clock
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Looks good but doesn't apply on top of your other patches for me. Can
you rebase?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/92e66acc/attachment.sig>
