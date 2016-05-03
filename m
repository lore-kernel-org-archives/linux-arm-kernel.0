From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 May 2016 15:17:23 +0100
Subject: next-20160503 build: 1 failures 12 warnings (next-20160503)
In-Reply-To: <E1axZpG-000664-AK@optimist>
References: <E1axZpG-000664-AK@optimist>
Message-ID: <20160503141723.GR6292@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2016 at 01:53:18PM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an ARM allmodconfig due to:

> 	arm-allmodconfig
> ../drivers/pinctrl/bcm/pinctrl-ns2-mux.c:540:17: error: 'pinctrl_utils_dt_free_map' undeclared here (not in a function)

caused by b5aa1006e4a93 (pinctrl: ns2: add pinmux driver support for
Broadcom NS2 SoC) - presumably just a missing dependency.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160503/33e6ab74/attachment.sig>
