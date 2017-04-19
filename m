From: stuyoder@gmail.com (Stuart Yoder)
Date: Tue, 18 Apr 2017 22:44:20 -0500
Subject: [PATCH v2 8/9] staging: fsl-dpaa2/eth: Add TODO file
In-Reply-To: <20170412162538.25302-9-ruxandra.radulescu@nxp.com>
References: <20170412162538.25302-1-ruxandra.radulescu@nxp.com>
 <20170412162538.25302-9-ruxandra.radulescu@nxp.com>
Message-ID: <CAEac7ta6h=_TT9MCZc8G4-raN47HrAphKf4ufUurX+zoOjm1gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 11:25 AM, Ioana Radulescu
<ruxandra.radulescu@nxp.com> wrote:
> Add a list of TODO items for the Ethernet driver
>
> Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
> ---
> v2: Add note
>
>  drivers/staging/fsl-dpaa2/ethernet/TODO | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 drivers/staging/fsl-dpaa2/ethernet/TODO
>
> diff --git a/drivers/staging/fsl-dpaa2/ethernet/TODO b/drivers/staging/fsl-dpaa2/ethernet/TODO
> new file mode 100644
> index 000000000000..110e66d44b42
> --- /dev/null
> +++ b/drivers/staging/fsl-dpaa2/ethernet/TODO
> @@ -0,0 +1,14 @@
> +* Add a DPAA2 MAC kernel driver in order to allow PHY management; currently
> +  the DPMAC objects and their link to DPNIs are handled by MC internally
> +  and all PHYs are seen as fixed-link
> +* add more debug support: decide how to expose detailed debug statistics,
> +  add ingress error queue support
> +* MC firmware uprev; the DPAA2 objects used by the Ethernet driver need to
> +  be kept in sync with binary interface changes in MC
> +* refine README file
> +* cleanup
> +
> +NOTE: None of the above is must-have before getting the DPAA2 Ethernet driver
> +out of staging. The main requirement for that is to have the drivers it
> +depends on, fsl-mc bus and DPIO driver, moved to drivers/bus and drivers/soc
> +respectively.

The TODO file should have contact info (I think)...look at other
drivers/staging TODO
for examples.

Stuart
