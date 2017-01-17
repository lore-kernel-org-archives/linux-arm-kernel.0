From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Jan 2017 21:45:10 -0800
Subject: [GIT PULL] i.MX fixes for 4.10, 2nd round
In-Reply-To: <20170110074949.GD20956@dragon>
References: <20170110074949.GD20956@dragon>
Message-ID: <20170117054510.GA16607@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 03:49:51PM +0800, Shawn Guo wrote:
> The following changes since commit 116dad7d4339d0965169df8a864fc829f684794d:
> 
>   ARM: dts: imx6: Disable "weim" node in the dtsi files (2017-01-03 10:59:07 +0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.10-2
> 
> for you to fetch changes up to 37530e74609a28ae3a3b51e7685fe54a00b1e2f2:
> 
>   ARM: dts: imx6qdl-nitrogen6_som2: fix sgtl5000 pinctrl init (2017-01-10 10:51:14 +0800)
> 
> ----------------------------------------------------------------
> i.MX fixes for 4.10, 2nd round:
>  - A couple of Nitrogen6 device tree fixes for audio codec probe
>    failure, which is caused by that pinctrl setting for codec clock
>    was not in the correct device node.

Merged, thanks.


-Olof
