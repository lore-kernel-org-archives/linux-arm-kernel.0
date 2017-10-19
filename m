From: Hermann.Lauer@iwr.uni-heidelberg.de (Hermann Lauer)
Date: Thu, 19 Oct 2017 12:36:18 +0200
Subject: compile error in 4.14-rc5 with nvidia tegra enabled
In-Reply-To: <c3afe94a-a2eb-05c3-9838-ff1a4871736d@kapsi.fi>
References: <20171019084210.lql5kffhluvxvquu@lemon.iwr.uni-heidelberg.de>
 <d006a085-d81f-4632-35c9-4e9d607a6504@nvidia.com>
 <c3afe94a-a2eb-05c3-9838-ff1a4871736d@kapsi.fi>
Message-ID: <20171019103618.anszbwgnrwv45vb5@lemon.iwr.uni-heidelberg.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 01:21:02PM +0300, Mikko Perttunen wrote:
> Arnd Bergmann raised this issue previously[1], but I assumed it would only
> happen on some obscure configuration, as clearly arm tegra_defconfig and
> multi_v7_defconfig and arm64 defconfig are building.
> 
> It would be interesting to know how this is being triggered here.

basis is the config-4.13.0-1-armmp from Debian's sid linux-image package -
will send the exact config when I fetched it from the Allwinner A20 (BananaPro)
System. Toolchain is the Debian stretch toolchain.

Thanks for carering,
  Hermann

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 205; 69120 Heidelberg; Tel: (06221)54-14405 Fax: -14427
Email: Hermann.Lauer at iwr.uni-heidelberg.de
