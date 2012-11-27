From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 27 Nov 2012 14:28:41 -0200
Subject: [PATCH v2] ARM: dts: mx27: Fix the AIPI bus for FEC
In-Reply-To: <1353525578-20309-1-git-send-email-fabio.estevam@freescale.com>
References: <1353525578-20309-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <CAOMZO5BZnpNrS_kKiqTmzYtzW7jQOtmHN-3cGH-10rj2v66Jjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Wed, Nov 21, 2012 at 5:19 PM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:
> FEC controller is connected to AIPI2 bus.
>
> Also fix the AIPI1 address range.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Remove ethernet from aipi1 bus on phytec board.

This one is a bug fix. Could this be applied?

Regards,

Fabio Estevam
