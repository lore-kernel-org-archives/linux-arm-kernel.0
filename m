From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 19 Dec 2013 00:30:15 -0200
Subject: [PATCH V3 1/2] ARM: imx: add vddsoc/pu setpoint info into dts
In-Reply-To: <112fab48e08c43749c0797328b1f1ee1@DM2PR03MB317.namprd03.prod.outlook.com>
References: <1387402010-31749-1-git-send-email-b20788@freescale.com>
 <CAOMZO5DCGOkUtWmEok-uEFsUpGLF+93Vhm9XFs02yH9Z+eV0uQ@mail.gmail.com>
 <ADD49D66-30FE-4D87-88D6-F8AE07376F3F@freescale.com>
 <112fab48e08c43749c0797328b1f1ee1@DM2PR03MB317.namprd03.prod.outlook.com>
Message-ID: <CAOMZO5DzKbOovk=k0ryWsdUzwdx4y_3JSytNY7LiWhhq3AhtHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 12:13 AM, Anson.Huang at freescale.com
<Anson.Huang@freescale.com> wrote:
> After re-consideration, I think below should be better:
> arm-supply: regulator node supplying arm.
> pu-supply: regulator node supplying pu.
> soc-supply: regulator node supplying soc.

Yes, this looks better.

Regards,

Fabio Estevam
