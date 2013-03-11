From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Mar 2013 10:50:04 -0300
Subject: [PATCH] ARM: imx: fix typo "DEBUG_IMX50_IMX53_UART"
In-Reply-To: <1363009649.3137.78.camel@x61.thuisdomein>
References: <1363007760.3137.69.camel@x61.thuisdomein>
 <20130311133720.GB25910@S2101-09.ap.freescale.net>
 <CAOMZO5AhjKV=ja+Agr_pMg4ghB6Vux2ciBnr_M8SQuS4AQ4Bzg@mail.gmail.com>
 <1363009649.3137.78.camel@x61.thuisdomein>
Message-ID: <CAOMZO5DFh_H5murFk_qR=v+kA2vu46rEjgU4cjjrO2gKtYA5mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 11, 2013 at 10:47 AM, Paul Bolle <pebolle@tiscali.nl> wrote:

> That's not correct:
>     $ git grep -n DEBUG_IMX50_IMX53_UART v3.9-rc2
>     v3.9-rc2:arch/arm/Kconfig.debug:495:                                            DEBUG_IMX50_IMX53_UART || \

Yes, you are right. I missed to remove one entry.
