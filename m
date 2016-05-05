From: robh@kernel.org (Rob Herring)
Date: Thu, 5 May 2016 17:25:21 -0500
Subject: [v10, 1/7] Documentation: DT: update Freescale DCFG compatible
In-Reply-To: <1462417950-46796-2-git-send-email-yangbo.lu@nxp.com>
References: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
 <1462417950-46796-2-git-send-email-yangbo.lu@nxp.com>
Message-ID: <20160505222521.GA18377@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2016 at 11:12:24AM +0800, Yangbo Lu wrote:
> Update Freescale DCFG compatible with 'fsl,<chip>-dcfg' instead
> of 'fsl,ls1021a-dcfg' to include more chips such as ls1021a,
> ls1043a, and ls2080a.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v8:
> 	- Added this patch
> Changes for v9:
> 	- Added a list for the possible compatibles
> Changes for v10:
> 	- None
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
