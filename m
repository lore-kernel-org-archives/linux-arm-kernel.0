From: olof@lixom.net (Olof Johansson)
Date: Tue, 28 Jul 2015 12:32:38 +0200
Subject: [GIT PULL] ARM: imx: fixes for 4.2, 2nd round
In-Reply-To: <20150728060437.GF12927@tiger>
References: <20150728060437.GF12927@tiger>
Message-ID: <20150728103238.GA21345@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 02:04:37PM +0800, Shawn Guo wrote:
> The following changes since commit d438462c20a300139c2e5e65b96cadaa21b58d9a:
> 
>   ARM: imx6: gpc: always enable PU domain if CONFIG_PM is not set (2015-07-08 22:52:08 +0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.2-2
> 
> for you to fetch changes up to e053f96b1a00022b4e2c7ceb7ac0229646626507:
> 
>   ARM: dts: i.MX35: Fix can support. (2015-07-25 11:35:08 +0800)
> 
> ----------------------------------------------------------------
> The i.MX fixes for 4.2, 2nd round:
>  - Add the required second clock for i.MX35 FlexCAN in device tree,
>    so that the device can be probed by kernel successfully.
> 
> ----------------------------------------------------------------
> Denis Carikli (1):
>       ARM: dts: i.MX35: Fix can support.

Thanks, merged.


-Olof
