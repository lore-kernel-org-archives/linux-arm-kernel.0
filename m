From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 15 May 2014 15:56:30 +0100
Subject: [PATCH] ARM: QCOM: Enable ARM_AMBA option for Qcom SOCS.
In-Reply-To: <4FB5A6A0-B4C5-4E97-AD7D-8049CFA60393@codeaurora.org>
References: <1400148535-30772-1-git-send-email-srinivas.kandagatla@linaro.org>
 <4FB5A6A0-B4C5-4E97-AD7D-8049CFA60393@codeaurora.org>
Message-ID: <5374D59E.2010502@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Kumar,
On 15/05/14 15:31, Kumar Gala wrote:
> I?d rather have the driver have the select of ARM_AMBA and not the core support.  We clearly don?t need to build ARM_AMBA in to function.

Shouldn?t driver depend on it rather than selecting it?

Suggested approach will end up changing the way its done on other SOCs,
Currently all the SOCs select ARM_AMBA at there machine level Kconfig 
rather than each individual driver selecting it.

Am open to do it either way but doing it the way it exists is the 
something more acceptable I thought.


thanks,
srini
