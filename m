From: broonie@kernel.org (Mark Brown)
Date: Wed, 6 Nov 2013 09:53:38 +0000
Subject: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F82875482@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101182514.GE2493@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F8287439D@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131104161537.GI2493@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F82875482@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <20131106095338.GG11602@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 03:21:49AM +0000, Li Xiubo wrote:

> As your opinions, should I move the four register writing operations to .set_sysclk/set_clkdiv/... functions too ?
> Or just add a clk_disable_unprepare() after them here, and then add clk_prepare_enable in one of .set_sysclk/set_clkdiv/...?

The latter.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131106/4797fbb6/attachment.sig>
