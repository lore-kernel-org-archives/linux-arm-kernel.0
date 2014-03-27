From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 27 Mar 2014 12:35:32 -0300
Subject: [PATCH 1/1] ARM: imx: Add DTSC02 platform (i.MX27)
In-Reply-To: <1395934153-19416-1-git-send-email-gcembed@gmail.com>
References: <1395934153-19416-1-git-send-email-gcembed@gmail.com>
Message-ID: <CAOMZO5AwfrXVoZfCKFQHBTDcUm4cfAVVX6fJabY0_S0gtbX_eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ga?tan,

On Thu, Mar 27, 2014 at 12:29 PM, Ga?tan Carlier <gcembed@gmail.com> wrote:
>
> Signed-off-by: Ga?tan Carlier <gcembed@gmail.com>
> ---
>  arch/arm/mach-imx/Kconfig       |   17 ++
>  arch/arm/mach-imx/Makefile      |    1 +
>  arch/arm/mach-imx/mach-dtsc02.c |  416 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 434 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-imx/mach-dtsc02.c

My understanding is that new board files are not allowed for ARM.

Have you considered creating a device tree implementation instead?

>From a quick look, all the devices you are registering are currently
supported on device tree.

Regards,

Fabio Estevam
