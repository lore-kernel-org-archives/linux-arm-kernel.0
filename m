From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Mar 2014 16:35:18 +1100
Subject: linux-next: manual merge of the pwm tree with the arm-soc tree
Message-ID: <20140324163518.a96d786dbfdef5b71619d60b@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

Today's linux-next merge of the pwm tree got a conflict in
arch/arm/mach-pxa/Kconfig between commit c7dc7d49fa8c ("ARM: pxa: select
I2C_GPIO only if I2C is on") from the arm-soc tree and commit
557fe99d9d49 ("pwm: Remove obsolete HAVE_PWM Kconfig symbol") from the
pwm tree.

I fixed it up (the former also remove the select of HAVE_PWM) and can
carry the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140324/adcea860/attachment.sig>
