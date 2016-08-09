From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 9 Aug 2016 11:09:27 +0800
Subject: [PATCH 0/3] ARM: dts: pinctrl-imx: some cleanups and fixes
In-Reply-To: <1467749993-14533-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1467749993-14533-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20160809030927.GJ4678@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2016 at 10:19:50PM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> when I asked Andreas F?rber to drop the function device nodes in his
> patch that added support for the Udoo Neo boards, he rightfully said:
> "OK, will do. Adopted from imx6sx-sdb.dtsi and imx6sx-sabreauto.dts -
> please update the existing files to be like you expect new ones to be.".
> This is done in patch 1. While the short stat for this patch is
> 
> 	87 files changed, 7717 insertions(+), 7899 deletions(-)

I do not feel this is really necessary.  People should always refer to
the latest dts addition as example.

Shawn
