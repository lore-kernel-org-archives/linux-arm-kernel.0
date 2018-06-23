From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 23 Jun 2018 12:47:13 -0300
Subject: [PATCH] Fix for clk disable issue on imx6ul
In-Reply-To: <CAOMZO5DJGCESqtSqbEw4O0Vxv3noUoCrTgbRCmwB2fJdVvu0RQ@mail.gmail.com>
References: <1529636119-4076-1-git-send-email-chakra@openedev.com>
 <CAOMZO5DJGCESqtSqbEw4O0Vxv3noUoCrTgbRCmwB2fJdVvu0RQ@mail.gmail.com>
Message-ID: <CAOMZO5BSVKSEjk1inZb_yA6VNkZiW_gWK3LdzkAzwZzJb+hVfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 23, 2018 at 12:38 PM, Fabio Estevam <festevam@gmail.com> wrote:

> Looking at the CCM_CCGR0 register (address: 20C_4068) there is no
> aips_tz3 clock gate in bits 31-30.
>
> Bits 31-30 are gpio2_clocks and Anson has recently sent a patch adding
> support for it:
> https://patchwork.kernel.org/patch/10481351/

Sorry, the correct link for the imx6ul patch is this one instead:
https://patchwork.kernel.org/patch/10445059/
