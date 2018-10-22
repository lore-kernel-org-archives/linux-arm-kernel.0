From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 22 Oct 2018 09:33:16 -0300
Subject: [PATCH v1] ARM: dts: imx6ul: ccimx6ulsom: Add support for
 wireless SOM variant
In-Reply-To: <1540200443-24773-2-git-send-email-alex.gonzalez@digi.com>
References: <1540200443-24773-1-git-send-email-alex.gonzalez@digi.com>
 <1540200443-24773-2-git-send-email-alex.gonzalez@digi.com>
Message-ID: <CAOMZO5CeZN5QhGha8rOm6qvSPmeVAPjQogmYsHLj5BE4CJ2jAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2018 at 6:28 AM Alex Gonzalez <alex.gonzalez@digi.com> wrote:
>
> The wireless variants of the ConnecCore 6UL SOM include a Qualcomm
> QCA6564 wireless chip with dual WiFi and Bluetooth.
>
> Both the ConnectCore 6UL SBC Express and Pro boards fit a wireless SOM.
>
> The Wifi is connected through the SDIO interface on usdhc1 and the
> Bluetooth is connected via uart1.
>
> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
