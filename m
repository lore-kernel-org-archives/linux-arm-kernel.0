From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Mar 2018 19:04:31 -0300
Subject: [PATCH] ARM: dts: i.MX25: define SSI FIFO depth
In-Reply-To: <1520373499-13623-1-git-send-email-martin@kaiser.cx>
References: <1520373499-13623-1-git-send-email-martin@kaiser.cx>
Message-ID: <CAOMZO5DAxDixb-mkTefd39bo6qeyNrdqd0ZxSmCUDYtKSdNrZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2018 at 6:58 PM, Martin Kaiser <martin@kaiser.cx> wrote:
> According to the i.MX25 reference manuals, each SSI has four FIFOs. All
> of those FIFOs can store up to 15 entries.
>
> The fsl_ssi driver's internal default for the FIFO depth in 8. Set our
> non-default FIFO depth explicitly in the Device Tree.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
