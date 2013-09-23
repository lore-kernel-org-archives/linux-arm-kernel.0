From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 23 Sep 2013 08:48:16 +0200
Subject: [PATCH] i2c: s3c2410: fix clk_disable/clk_unprepare warnings
In-Reply-To: <20130917113153.41b0305d6892170ba8e1ecf7@linaro.org>
References: <20130917113153.41b0305d6892170ba8e1ecf7@linaro.org>
Message-ID: <20130923064816.GA3051@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 11:31:53AM -0500, Kim Phillips wrote:
> commit d16933b33914a6dff38a4ecbe8edce44a17898e8 "i2c: s3c2410: Move
> location of clk_prepare_enable() call in probe function" refactored
> clk_enable and clk_disable calls yet neglected to remove the
> clk_disable_unprepare call in the module's remove().

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130923/a0e675ae/attachment-0001.sig>
