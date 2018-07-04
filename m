From: sergey.lapin@cogentembedded.com (Sergey Lapin)
Date: Wed, 4 Jul 2018 21:26:57 +0300
Subject: [PATCH 2/2] ARM: imx51: Configure M4IF to avoid visual artifacts
In-Reply-To: <1530720842-28281-2-git-send-email-festevam@gmail.com>
References: <1530720842-28281-1-git-send-email-festevam@gmail.com>
 <1530720842-28281-2-git-send-email-festevam@gmail.com>
Message-ID: <CACDsZ46=j6FxyZm1Ck-0H5HjWZz_uzMw5W1dRzeT4fVqcxXJpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 4, 2018 at 7:14 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> Configure the M4IF registers as per the vendor bootloader
> to avoid visual artifacts during video playback.
>
> This way we don't need to rely on the bootloader configuration for
> optimal IPU/VPU bus priorities.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Tested-by: Sergey Lapin <sergey.lapin@cogentembedded.com>
