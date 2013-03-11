From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 11 Mar 2013 15:57:02 +0100
Subject: [PATCH] ARM: imx: fix typo "DEBUG_IMX50_IMX53_UART"
In-Reply-To: <CAOMZO5DFh_H5murFk_qR=v+kA2vu46rEjgU4cjjrO2gKtYA5mQ@mail.gmail.com>
References: <1363007760.3137.69.camel@x61.thuisdomein>
 <20130311133720.GB25910@S2101-09.ap.freescale.net>
 <CAOMZO5AhjKV=ja+Agr_pMg4ghB6Vux2ciBnr_M8SQuS4AQ4Bzg@mail.gmail.com>
 <1363009649.3137.78.camel@x61.thuisdomein>
 <CAOMZO5DFh_H5murFk_qR=v+kA2vu46rEjgU4cjjrO2gKtYA5mQ@mail.gmail.com>
Message-ID: <1363013822.3137.82.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-03-11 at 10:50 -0300, Fabio Estevam wrote:
> I missed to remove one entry.

Actually, your patch was fine. DEBUG_IMX50_IMX53_UART returned a bit
later - and by accident - in commit
f8c95fe6d9adad72fc7bce90f4ab68d119f50c5b ("ARM: imx: support DEBUG_LL
uart port selection for all i.MX SoCs").


Paul Bolle
