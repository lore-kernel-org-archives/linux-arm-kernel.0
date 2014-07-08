From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 8 Jul 2014 08:15:16 +0100
Subject: [PATCH 3/5] phy: miphy365x: Provide support for the MiPHY356x
 Generic PHY
In-Reply-To: <CAG374jB6YjMDjaEk=+etrw46mUkXgBHBUhPTPUCyo-P_Wzn32g@mail.gmail.com>
References: <1404133317-25953-1-git-send-email-lee.jones@linaro.org>
 <1404133317-25953-4-git-send-email-lee.jones@linaro.org>
 <CAG374jB6YjMDjaEk=+etrw46mUkXgBHBUhPTPUCyo-P_Wzn32g@mail.gmail.com>
Message-ID: <20140708071516.GL6407@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 04 Jul 2014, Gabriel Fernandez wrote:
> On 30 June 2014 15:01, Lee Jones <lee.jones@linaro.org> wrote:
> > The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
> > devices. It has 2 ports which it can use for either; both SATA, both
> > PCIe or one of each in any configuration.
> >
> > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/phy/Kconfig         |  10 +
> >  drivers/phy/Makefile        |   1 +
> >  drivers/phy/phy-miphy365x.c | 630 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 641 insertions(+)
> >  create mode 100644 drivers/phy/phy-miphy365x.c

All fixed, thanks Gabi.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
