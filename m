From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 22 Jul 2013 18:56:11 -0300
Subject: [PATCH v2 1/2] ARM: dts: mx6: Add support for mx6q nitrogen board
In-Reply-To: <1374530056-31335-1-git-send-email-festevam@gmail.com>
References: <1374530056-31335-1-git-send-email-festevam@gmail.com>
Message-ID: <CAOMZO5Cecs7DTHr_2KWXSBeTPXSZ_xZK7xbOxE8M=MyN4HWBrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Jul 22, 2013 at 6:54 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> mx6q sabrelite and nitrogen boards are hardware compatible.
>
> Boundary Devices have a line of nitrogen boards based on quad/dual-lite and solo
> variants.
>
> Let's consolidate the common peripheral nodes into imx6qdl-nitrogen.dtsi and
> add support for the mx6 quad nitrogen board.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

I missed to add:

Changes since v1:

- Put the nodes in alphabetical order
- Also add sata node for sabrelite
