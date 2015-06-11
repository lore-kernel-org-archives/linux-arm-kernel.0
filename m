From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 10 Jun 2015 17:02:20 -0700
Subject: [GIT PULL v2 3/4] ARM: imx: device tree changes for 4.2
In-Reply-To: <20150604023926.GA24623@dragon> (Shawn Guo's message of "Thu, 4
 Jun 2015 10:39:26 +0800")
References: <20150604023926.GA24623@dragon>
Message-ID: <7hbngni037.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo <shawnguo@kernel.org> writes:

> Changes since v1:
>  - Rebase to only share imx7d clock ID header with imx/dt branch
>  - Add one patch correcting imx6dl gpt compatible string
>
> The following changes since commit 0ed4668a5fafa922f450fca4b3431610a21626c5:
>
>   dt-bindings: add imx7d clock ID definitions (2015-06-03 14:41:29 +0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.2
>
> for you to fetch changes up to 4e415ed8143f7f26f448e932a2d1b52ddc6ecbcd:
>
>   ARM: dts: imx6dl: add imx6dl gpt specific compatible string (2015-06-03 17:04:53 +0800)
>
> ----------------------------------------------------------------
> The i.MX device tree changes for 4.2:
>  - Add device tree for i.MX7D SoC and imx7d-sdb board
>  - New i.MX6 board support: Armadeus Systems APF6, Gateworks GW5510,
>    and aristainetos2 boards
>  - Change LVDS to use simple-panel for nitrogen6x and sabrelite boards
>  - Add Wifi/Bluetooth devices support for cubox-i board
>  - Remove unused regulators and correct OTG roles setting for
>    imx6sl-warp board
>  - Add I2C support for imx23-olinuxino board
>  - Move imx6qdl HDMI device to a better place
>  - Add power-domain for imx6qdl CODA device
>
> ----------------------------------------------------------------

Applied to next/dt,

Thanks,

Kevin
