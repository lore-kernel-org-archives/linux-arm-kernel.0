From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 27 Nov 2018 11:29:13 +0530
Subject: [PATCH v3] ARM: dts: sun8i: Add the H3/H5 CSI controller
In-Reply-To: <20181120145241.18618-1-maxime.ripard@bootlin.com>
References: <20181120145241.18618-1-maxime.ripard@bootlin.com>
Message-ID: <CAMty3ZCRdkUdEn7QMCBWcopKr0L0ptBDjdKc0i45A70uEx-YhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 9:53 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> From: Myl?ne Josserand <mylene.josserand@bootlin.com>
>
> The H3 and H5 features the same CSI controller that was initially found on
> the A31.
>
> Add a DT node for it.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v3:
>   - Removed the CSI MCLK pin from the default pin group

If I'm not wrong, PE1 is CSI_MCLK and PE0 is CSI_PCLK so we have PE0
and PE1 removed.
