From: broonie@kernel.org (Mark Brown)
Date: Mon, 25 Nov 2013 17:29:04 +0000
Subject: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
In-Reply-To: <CAOMZO5DW3pSxPGe6N0CRiCEc+iVV9X_13JbzAvuFbb4jide+zw@mail.gmail.com>
References: <20131122142231.GA1741@ulmo.nvidia.com>
 <20131122145224.GO14725@sirena.org.uk>
 <20131125031029.GC11613@S2101-09.ap.freescale.net>
 <CAOMZO5CtNnma8Sv35P3jeNYQiLV=jdmN0Q7w2_LFMOj-nTbPZg@mail.gmail.com>
 <20131125133659.GA30476@S2101-09.ap.freescale.net>
 <CAOMZO5DW3pSxPGe6N0CRiCEc+iVV9X_13JbzAvuFbb4jide+zw@mail.gmail.com>
Message-ID: <20131125172904.GP14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 12:43:58PM -0200, Fabio Estevam wrote:

> What commit provides this regulator core functionality?

regulator: core: Provide a dummy regulator with full constraints

> Looks like it has not reached 3.13-rc1.

Yes, it did.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/650b4eb8/attachment.sig>
