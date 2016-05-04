From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 May 2016 16:10:28 +0100
Subject: [PATCH 1/2] Revert "ASoC: rockchip: i2s: remove unused variables"
In-Reply-To: <1462373686-21794-1-git-send-email-john@metanate.com>
References: <1462373686-21794-1-git-send-email-john@metanate.com>
Message-ID: <20160504151028.GW6292@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 04, 2016 at 03:54:45PM +0100, John Keeping wrote:
> This reverts commit 5938448b99275cba95167c3f9d39ca9225fdad38.
> 
> It turns out that the commit that made these variables unused is wrong
> so we're about to revert it.  Bring back the variables in prepration.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160504/532607aa/attachment.sig>
