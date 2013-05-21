From: broonie@kernel.org (Mark Brown)
Date: Tue, 21 May 2013 13:18:49 -0500
Subject: [PATCH v4] ASoC: dfbmcs320: make the driver common for other BT
 modules
In-Reply-To: <1368879900-28395-1-git-send-email-Baohua.Song@csr.com>
References: <1368879900-28395-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130521181849.GG1627@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 18, 2013 at 08:25:00PM +0800, Barry Song wrote:
> DFBM-CS320 is only one of bluetooth modules using CSR bluetooth chips,
> we don't want everyone to have a seperate codec driver. anyway, the
> feature of Bluetooth SCO is same on all platforms, so this patch
> makes the DFBM-CS320 driver become a common BT SCO link driver.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130521/11d69457/attachment-0001.sig>
