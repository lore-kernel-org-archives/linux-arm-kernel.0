From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 May 2017 11:36:07 +0100
Subject: next-20170518 build: 1 failures 4 warnings (next-20170518)
In-Reply-To: <E1dBFeZ-0004Qr-Jp@optimist>
References: <E1dBFeZ-0004Qr-Jp@optimist>
Message-ID: <20170518103607.u7l7vr2rnv3rsysu@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 08:15:19AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an ARM allmodconfig due to:

> 	arm-allmodconfig
> Error: ../arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts:69.17-18 syntax error

caused by ff175ef29e9069ac46 (ARM: sun8i: v3s: add support for Lichee Pi
Zero w/ dock board).  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170518/e0bd7915/attachment.sig>
