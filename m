From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 7 Mar 2012 21:08:33 +0000
Subject: [PATCH v2 00/17] ASoC: add imx-sgtl5000 machine driver working
 with fsl_ssi
In-Reply-To: <4F57CDAC.9030604@freescale.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <4F57CDAC.9030604@freescale.com>
Message-ID: <20120307210833.GO3107@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 03:05:48PM -0600, Timur Tabi wrote:

> This happens frequently to my drivers whenever something in ASoC changes.
>  And it's a pain to debug because ASoC never tells me what's wrong.

Turn on the debug logging in soc-core.c and it'll chatter away about
what's up; not finding cards is a perfectly normal thing s we're not too
verbose.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120307/cbaa1243/attachment-0001.sig>
