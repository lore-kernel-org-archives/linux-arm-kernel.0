From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Dec 2013 12:34:40 +0000
Subject: [PATCH v2 5/7] mfd: pm8921: Use ssbi regmap
In-Reply-To: <1387831563-13535-6-git-send-email-sboyd@codeaurora.org>
References: <1387831563-13535-1-git-send-email-sboyd@codeaurora.org>
 <1387831563-13535-6-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131230123440.GT31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 12:46:01PM -0800, Stephen Boyd wrote:
> Use a regmap so that the pm8xxx read/write APIs can be removed
> once all consumer drivers are converted.

Reviewed-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131230/1e1d3352/attachment.sig>
