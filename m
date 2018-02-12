From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 12 Feb 2018 10:48:43 -0200
Subject: [PATCHv4 1/2] ARM: imx53: add secure-reg-access support for PMU
In-Reply-To: <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
 <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
Message-ID: <CAOMZO5A6OSe_i8L_9NXGR-FjFg1msGeybtj9Yk5FLKszZMe+SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 10:39 AM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> On i.MX53 it is necessary to set the DBG_EN bit in the
> platform GPC register to enable access to PMU counters
> other than the cycle counter.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
