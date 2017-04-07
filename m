From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 7 Apr 2017 14:48:47 +0200
Subject: [PATCH v3 16/20] ARM: dts: sun50i-a64: enable dwmac-sun8i on
 pine64
In-Reply-To: <20170403113847.dca2tetjit7xoxyn@lukather>
References: <20170403091444.29876-1-clabbe.montjoie@gmail.com>
 <20170403091444.29876-17-clabbe.montjoie@gmail.com>
 <20170403113847.dca2tetjit7xoxyn@lukather>
Message-ID: <20170407124847.GA15546@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 01:38:47PM +0200, Maxime Ripard wrote:
> On Mon, Apr 03, 2017 at 11:14:40AM +0200, Corentin Labbe wrote:
> > The dwmac-sun8i hardware is present on the pine64
> > It uses an external PHY via RMII.
> > 
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> 
> Looks fine, but please use "arm64: allwinner: pine64: " as your title
> prefix. It applies to all your other patches (and the arm ones should
> be "arm: <family>: <soc-or-board>:".
> 

Will fix them

Thanks
Corentin Labbe
