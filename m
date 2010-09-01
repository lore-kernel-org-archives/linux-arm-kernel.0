From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Wed, 1 Sep 2010 19:52:41 +0200
Subject: [PATCH 5/9] sdhci-5:add the 32BIT_CMD_TRANS_COMBINATION quirk to
	support FSl eSDHC
In-Reply-To: <1283334494-12678-1-git-send-email-r65037@freescale.com>
References: <1283334494-12678-1-git-send-email-r65037@freescale.com>
Message-ID: <AANLkTimHF4uS+ACLOKPmo86sd5Cvb77XdNB2jZNUDeU=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/1 Richard Zhu <r65037@freescale.com>:
> The FSL's eSDHC have one 32bit register that combine the two
> 16bit Transfer Mode and Command registers.
> Add this quirk to let SW driver to support FSL's eSDHC.

What happens if you do this for every SDHCI host? Is there one that
breaks if changing the two registers are combined into single 32-bit
write?

Best Regards,
Micha? Miros?aw
