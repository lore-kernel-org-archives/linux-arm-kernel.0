From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 5 Oct 2017 13:14:44 +0200
Subject: [PATCH v1] i2c:i2c-stm32f7: fix setup structure
In-Reply-To: <1506000609-27409-1-git-send-email-pierre-yves.mordret@st.com>
References: <1506000609-27409-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20171005111444.77qib2ddnz4jmbnr@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 03:30:09PM +0200, Pierre-Yves MORDRET wrote:
> I2C drive setup structure is not properly allocated.
> Make it static instead of pointer to store driver data.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Ouch! How did it work before?

Applied to for-current, thanks! Please provide a Fixes: tag next time,
did this for you now.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171005/2b0893d1/attachment.sig>
