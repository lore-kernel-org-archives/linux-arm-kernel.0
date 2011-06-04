From: olof@lixom.net (Olof Johansson)
Date: Sat, 4 Jun 2011 10:51:29 -0700
Subject: [PATCH v2] ARM: mx53: Fix alternate modes for MX53_PAD_PATA_DATA6
In-Reply-To: <1307205300-2084-1-git-send-email-festevam@gmail.com>
References: <1307205300-2084-1-git-send-email-festevam@gmail.com>
Message-ID: <BANLkTimJGuiCHMBsOM60zqMBWR_iJr6PgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 4, 2011 at 9:35 AM, Fabio Estevam <festevam@gmail.com> wrote:
> MX53_PAD_PATA_DATA6 can have the following alternate modes:
>
> PATA_DATA_6: ? ? ? ? ? ?mode 0
> GPIO2_6: ? ? ? ? ? ? ? ?mode 1
> EMI_NANDF_D_6: ? ? ? ? ?mode 3
> ESDHC4_DAT6 ? ? ? ? ? ? mode 4
> GPU3d_GPU_DEBUG_OUT_6 ? mode 5
> IPU_DIAG_BUS_6 ? ? ? ? ?mode 6
>
> Fix the modes accordingly.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Dinh Nguyen <dinh.nguyen@freescale.com>
> ---
>
> Changes since v1:
> - Improved subject and added a commit message

Thanks!

Not that I can verify the MUX changes, but:

Acked-by: Olof Johansson <olof@lixom.net>
