From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 25 Jul 2015 11:38:52 +0800
Subject: [PATCH v2] ARM: dts: i.MX35: Fix can support.
In-Reply-To: <1437640272-5054-1-git-send-email-denis@eukrea.com>
References: <20150722180434.GA745@pengutronix.de>
 <1437640272-5054-1-git-send-email-denis@eukrea.com>
Message-ID: <20150725033852.GJ12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 23, 2015 at 10:31:12AM +0200, Denis Carikli wrote:
> Since commit 3d42a379b6fa5b46058e3302b1802b29f64865bb
> ("can: flexcan: add 2nd clock to support imx53 and newer")
> the can driver requires a dt nodes to have a second clock.
> Add them to imx35 to fix probing the flex can driver on the
> respective platforms.
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>

Applied, thanks.
