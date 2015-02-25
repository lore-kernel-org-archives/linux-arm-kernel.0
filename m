From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 25 Feb 2015 14:17:03 -0300
Subject: [PATCH] ARM: dts: warp: Add initial WaRP Board support
In-Reply-To: <1424883739-374-1-git-send-email-otavio@ossystems.com.br>
References: <1424883739-374-1-git-send-email-otavio@ossystems.com.br>
Message-ID: <CAOMZO5Dvc8fNfHRHNzrr3DmsOxTFz=piz8tp-_qyQj--5O1irQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 2:02 PM, Otavio Salvador
<otavio@ossystems.com.br> wrote:
> The WaRP Board is a Wearable Reference Plaform. The board features:
>
>  - Freescale i.MX6 SoloLite processor with 512MB of RAM
>  - Freescale FXOS8700CQ 6-axis Xtrinsic sensor
>  - Freescale Kinetis KL16 MCU
>  - Freescale Xtrinsic MMA955xL intelligent motion sensing platform
>
> The board implements a hybrid architecture to address the evolving
> needs of the wearables market. The platform consists of a main board
> and an example daughtercard with the ability to add additional
> daughtercards for different usage models.
>
> For more information about the project, visit:
>
>  http://www.warpboard.org/
>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

Thanks, Otavio. It boots well on my warp, so:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
