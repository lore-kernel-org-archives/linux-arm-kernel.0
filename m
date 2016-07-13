From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 13 Jul 2016 15:40:53 +0200
Subject: [PATCH V2 00/15] a few sdhci/imx clean up and fix patches
In-Reply-To: <20160713085438.GA27041@shlinux2>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
 <20160712135422.GE8540@lunn.ch> <20160713085438.GA27041@shlinux2>
Message-ID: <20160713134053.GB6667@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Thanks for the suggestion.
> I think except patch 2 (mmc: sdhci-esdhc-imx: remove SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
> which is only a one line change, all others are good to be cherry-picked
> into stable.

You need to be very explicit about what you want going into
stable. Otherwise none of them will end up in stable.

Documentation/SubmittingPatches says you should include a Fixes: tag
in each patch indicating when the bug you are fixing was added to the
kernel. You should also be including Cc: stable at vger.kernel.org.

	Andrew
