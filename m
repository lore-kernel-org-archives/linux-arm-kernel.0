From: timur@freescale.com (Timur Tabi)
Date: Wed, 7 Mar 2012 15:05:48 -0600
Subject: [PATCH v2 00/17] ASoC: add imx-sgtl5000 machine driver working
 with fsl_ssi
In-Reply-To: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F57CDAC.9030604@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> Changes since v1:
>  * Address comments from Mark, Timur, and Sascha (Thanks for review).
>  * Drop patches that have been applied by Mark.

So I'm testing them now, and I get this on boot:

ALSA device list:
  No soundcards found.

This happens frequently to my drivers whenever something in ASoC changes.
 And it's a pain to debug because ASoC never tells me what's wrong.

I'm debugging it now.  I'll let you know when I find something.

-- 
Timur Tabi
Linux kernel developer at Freescale
