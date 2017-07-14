From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 14 Jul 2017 10:19:49 +0800
Subject: [PATCH 1/2 v2] ARM: dts: imx6ul-evk: Add DRM panel support
In-Reply-To: <1499960160-20852-1-git-send-email-marco.franchi@nxp.com>
References: <1499960160-20852-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <20170714021948.GA3172@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 12:35:59PM -0300, Marco Franchi wrote:
> It is preferred to use the panel compatible string rather than passing the LCD
> timming in the device tree.
> 
> So pass the "innolux,at043tn24" compatible string to describe the parallel LCD
> on this board.
> 
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Applied both, thanks.
