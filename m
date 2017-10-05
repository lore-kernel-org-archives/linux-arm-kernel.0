From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 5 Oct 2017 12:56:29 -0300
Subject: [PATCH v3 1/2] ARM: dts: imx: Fix incorrect display nodes notation
In-Reply-To: <1507213901-1349-1-git-send-email-marco.franchi@nxp.com>
References: <1507213901-1349-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <CAOMZO5Ct=UTPXVgqk2RajPs-_9VwAa6mMTSO3hJn+54hEb2yjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 11:31 AM, Marco Franchi <marco.franchi@nxp.com> wrote:
> The following build warnings are seen with W=1:
>
> Warning (unit_address_vs_reg): Node /display at di0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /display at di1 has a unit name, but no reg property
>
> Fix all these warnings by changing 'display at diX' to 'dispX'.
>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

This aligns the dts with the binding doc and also fixes the warnings, great!
https://git.pengutronix.de/cgit/pza/linux/commit/?h=imx-drm/next&id=dbfdd153d4aefec13460c97475737e59af92d8e2

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
