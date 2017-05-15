From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 15 May 2017 12:18:29 +0200
Subject: [PATCH v2] ARM: at91/defconfig: add MCAN driver to sama5_defconfig
In-Reply-To: <20170515101246.8913-1-wenyou.yang@atmel.com>
References: <20170515101246.8913-1-wenyou.yang@atmel.com>
Message-ID: <20170515101829.b7pssniko5b4ncih@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The correct subject prefix is ARM: configs: at91:

On 15/05/2017 at 18:12:46 +0800, Wenyou Yang wrote:
> Add the Controller Area Network (MCAN) driver compilation
> for sama5 default configuration. Is used by sama5d2 SoC for instance.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
> Changes in v2:
>  - Rebase on Linux-4.12-rc1.
> 
>  arch/arm/configs/sama5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
