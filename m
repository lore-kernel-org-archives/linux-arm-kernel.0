From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 14 Sep 2017 17:40:33 +0200
Subject: [PATCH v4 3/5] i2c: i2c-stm32f7: add driver
In-Reply-To: <1505399319-14782-4-git-send-email-pierre-yves.mordret@st.com>
References: <1505399319-14782-1-git-send-email-pierre-yves.mordret@st.com>
 <1505399319-14782-4-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20170914154033.gkovgxgjbghtqmre@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 14, 2017 at 04:28:37PM +0200, Pierre-Yves MORDRET wrote:
> This patch adds initial support for the STM32F7 I2C controller.
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Thanks for the quick update. I'd think the 'rate_max' variable can now
be dropped and replaced by 'rate'? If so, we can fix that later
incrementally.

Applied to for-next (will be in 4.14), thanks! The DTS patches need to
go via arm-soc.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170914/6eee4479/attachment.sig>
