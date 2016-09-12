From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Sep 2016 10:13:39 +0100
Subject: [PATCH v15.1 3/5] drm/rockchip: cdn-dp: add cdn DP support for
 rk3399
In-Reply-To: <1473480966-21572-1-git-send-email-zyw@rock-chips.com>
References: <1473473748-22331-4-git-send-email-zyw@rock-chips.com>
 <1473480966-21572-1-git-send-email-zyw@rock-chips.com>
Message-ID: <20160912091339.GY27946@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 09:16:06PM -0700, Chris Zhong wrote:
> Add support for cdn DP controller which is embedded in the rk3399
> SoCs. The DP is compliant with DisplayPort Specification,

Please don't new patches in reply to old serieses, especially not
individual patches in the middle of the series - it just makes
everything more confusing.  It becomes difficult to tell what the
version of the series that's actually expected is.  Please send the
whole series.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160912/5dbc680e/attachment.sig>
