From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 27 Nov 2017 11:29:32 -0800
Subject: [GIT PULL] bcm2835-dt-next-fixes-2017-11-15
In-Reply-To: <20171116203936.23633-1-eric@anholt.net>
References: <20171116203936.23633-1-eric@anholt.net>
Message-ID: <e1641746-1443-9a25-1d1c-b3477cf5de1f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2017 12:39 PM, Eric Anholt wrote:
> Hi Florian,
> 
> This is a little fix from Stefan for a warning that popped up when our
> -next and dtc's -next got merged.  Hopefully it can get pulled for
> 4.15 soon.
> 
> The following changes since commit fd3372db18d3d44ae4579243a8eacb5247d8c03a:
> 
>   ARM: dts: bcm2837-rpi-3-b: Add bcm43438 serial slave (2017-10-06 13:07:21 -0700)
> 
> are available in the Git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-dt-next-fixes-2017-11-15
> 
> for you to fetch changes up to 014d6da6cb2525d7f48fb08c705cb130cc7b5f4a:
> 
>   ARM: dts: bcm283x: Fix DTC warnings about missing phy-cells (2017-11-15 10:57:47 -0800)
> 
> ----------------------------------------------------------------
> This pull request brings in a fix for a warning that started occuring
> when dtc from -next got merged.
> 
> ----------------------------------------------------------------

Merged, thanks Eric.
-- 
Florian
