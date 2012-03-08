From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 8 Mar 2012 18:24:28 +0000
Subject: [PATCH v3 01/11] ASoC: core: missing set_fmt should not be
 complaint
In-Reply-To: <1331225990-27308-2-git-send-email-shawn.guo@linaro.org>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120308182427.GA3638@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 12:59:40AM +0800, Shawn Guo wrote:
> Not having a DAI link set_fmt operation is perfectly normal and
> should not be complaint.

Applied, thanks.  I'll wait for Timur's review on the rest before
applying.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120308/eebd7a5d/attachment.sig>
