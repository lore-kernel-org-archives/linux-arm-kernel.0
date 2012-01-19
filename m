From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Jan 2012 19:48:42 -0800
Subject: [PATCH V1] ARM: tegra: Pause DMA when reading transfer count
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A77E@HQMAIL01.nvidia.com>
References: <1326175511-28642-1-git-send-email-ldewangan@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A77E@HQMAIL01.nvidia.com>
Message-ID: <20120119034842.GA7145@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 12:48:26PM -0800, Stephen Warren wrote:
> Laxman Dewangan wrote at Monday, January 09, 2012 11:05 PM:
> > In order to read an accurate channel transfer count
> > from the APB DMA engine, the DMA controller must be
> > paused first.
> > 
> > Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>
> Tested-by: Stephen Warren <swarren@nvidia.com>
> 
> (Audio playback on Harmony booted using device tree works fine in my
> brief testing)

Thanks, applied.


-Olof
