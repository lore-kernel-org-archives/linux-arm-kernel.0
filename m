From: olof@lixom.net (Olof Johansson)
Date: Thu, 7 Jan 2016 06:13:24 +0100
Subject: [PATCH] ARM: dts: imx6q: clean up unused ipu2grp
In-Reply-To: <1450837377-23103-1-git-send-email-shawnguo@kernel.org>
References: <1450837377-23103-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20160107051324.GD26875@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 10:22:57AM +0800, Shawn Guo wrote:
> The pinctrl group ipu2grp is a leftover from the previous iomuxc DT
> cleanup.  It's not used by anyone now.  More importantly, it's getting
> in the way of saving the unnecessary pinfunc container node from the
> board dts files that include imx6q.dtsi.
> 
> Let's clean it up.
> 
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
> Hi arm-soc folks,
> 
> Olof just merged my 4.5 pull requests (thanks).  And here is one cleanup
> patch, which will be quite useful for imx6q board files we are going to
> add in the next development cycle.  It helps to save the pinfunc
> container node and thus one level of indentation from board dts.  So
> please apply it to arm-soc for 4.5 merge window.  Thanks.

Thanks, applied to next/dt.


-Olof
