From: broonie@kernel.org (Mark Brown)
Date: Fri, 15 Jul 2016 13:52:26 +0100
Subject: [PATCH 4/4] qcom: ipq4019: Add ASoC driver modules
In-Reply-To: <1468566426-19598-5-git-send-email-njaigane@codeaurora.org>
References: <1468566426-19598-1-git-send-email-njaigane@codeaurora.org>
 <1468566426-19598-5-git-send-email-njaigane@codeaurora.org>
Message-ID: <20160715125226.GJ30372@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 12:37:06PM +0530, njaigane at codeaurora.org wrote:

>  sound/soc/qcom/Kconfig                     |  47 ++
>  sound/soc/qcom/Makefile                    |   1 +
>  sound/soc/qcom/ipq4019/Makefile            |  16 +
>  sound/soc/qcom/ipq4019/ipq4019-adss.c      | 407 ++++++++++++++
>  sound/soc/qcom/ipq4019/ipq4019-adss.h      | 432 +++++++++++++++
>  sound/soc/qcom/ipq4019/ipq4019-codec.c     | 475 +++++++++++++++++
>  sound/soc/qcom/ipq4019/ipq4019-codec.h     |  91 ++++
>  sound/soc/qcom/ipq4019/ipq4019-cpu-dai.c   | 687 ++++++++++++++++++++++++
>  sound/soc/qcom/ipq4019/ipq4019-mbox.c      | 825 +++++++++++++++++++++++++++++
>  sound/soc/qcom/ipq4019/ipq4019-mbox.h      | 146 +++++
>  sound/soc/qcom/ipq4019/ipq4019-pcm-i2s.c   | 609 +++++++++++++++++++++
>  sound/soc/qcom/ipq4019/ipq4019-pcm-spdif.c | 664 +++++++++++++++++++++++
>  sound/soc/qcom/ipq4019/ipq4019-pcm-tdm.c   | 609 +++++++++++++++++++++
>  sound/soc/qcom/ipq4019/ipq4019-pcm.h       |  37 ++
>  sound/soc/qcom/ipq4019/ipq4019-stereo.c    | 313 +++++++++++
>  sound/soc/qcom/ipq4019/ipq4019.c           | 121 +++++

This is *far* too big to be a single patch.  Please at the very least
split this up into one patch per driver, look at the git history of
other drivers for examples of splitting things up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160715/c7400e9e/attachment.sig>
