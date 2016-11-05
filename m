From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 5 Nov 2016 17:35:50 -0200
Subject: [PATCH 1/9] ARM: dts: imx1: Remove skeleton.dtsi
In-Reply-To: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
References: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <CAOMZO5CUyZF5wXBxvcsJWSLt1NVzejpH0bZKedJfx3TfBPB2vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, Sep 6, 2016 at 12:53 PM, Fabio Estevam <fabio.estevam@nxp.com> wrote:
> The inclusion of skeleton.dtsi causes the following build warning:
>
> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
>
> Instead of fixing skeleton.dtsi, just add the top level definitions
> for address-cells and size-cell and remove its inclusion.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Are you OK with this series?
