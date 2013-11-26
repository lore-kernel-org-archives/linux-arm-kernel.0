From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Nov 2013 13:18:21 +0000
Subject: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
In-Reply-To: <CAOMZO5BM5Tfyfi05D3cyYHAVeR5X9R_5H2ceo_tfcb7Qn_-W7A@mail.gmail.com>
References: <20131122142231.GA1741@ulmo.nvidia.com>
 <20131122145224.GO14725@sirena.org.uk>
 <20131125031029.GC11613@S2101-09.ap.freescale.net>
 <CAOMZO5CtNnma8Sv35P3jeNYQiLV=jdmN0Q7w2_LFMOj-nTbPZg@mail.gmail.com>
 <20131125133659.GA30476@S2101-09.ap.freescale.net>
 <CAOMZO5DW3pSxPGe6N0CRiCEc+iVV9X_13JbzAvuFbb4jide+zw@mail.gmail.com>
 <20131125172904.GP14725@sirena.org.uk>
 <CAOMZO5D1qR8+RH=w67=2LVQVJXiuPSo7BDXWt+KaBf5sOUFuPQ@mail.gmail.com>
 <CAOMZO5BM5Tfyfi05D3cyYHAVeR5X9R_5H2ceo_tfcb7Qn_-W7A@mail.gmail.com>
Message-ID: <20131126131821.GM14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 06:58:30PM -0200, Fabio Estevam wrote:

> -late_initcall(regulator_init_complete);
> +core_initcall(regulator_init_complete);

No, like I said previously fiddling about with the initcall order is not
going to help.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131126/ed2c619b/attachment.sig>
