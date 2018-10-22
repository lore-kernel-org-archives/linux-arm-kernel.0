From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 22 Oct 2018 09:36:56 -0300
Subject: [PATCH 2/2] ARM: dts: ccimx6ulsbcpro: Add support for Goodix
 touch controller
In-Reply-To: <1540204399-12982-3-git-send-email-alex.gonzalez@digi.com>
References: <1540204399-12982-1-git-send-email-alex.gonzalez@digi.com>
 <1540204399-12982-3-git-send-email-alex.gonzalez@digi.com>
Message-ID: <CAOMZO5BhwsaLOG--kdpk4XB9jvOpxvTxx7rP22Ns9HZgrit83A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2018 at 7:34 AM Alex Gonzalez <alex.gonzalez@digi.com> wrote:

Please add a commit log.

> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
> ---
>  arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 19 +++++++++++++++++++
>  arch/arm/configs/imx_v6_v7_defconfig        |  1 +

Please split this into two patches: one for the dts and other for the
defconfig change, thanks.
