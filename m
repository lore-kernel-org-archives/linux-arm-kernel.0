From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 23 May 2014 15:59:27 +0100
Subject: [RFC v2 01/10] arm: fiq: Allow EOI to be communicated to the intc
In-Reply-To: <1400853478-5824-2-git-send-email-daniel.thompson@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-2-git-send-email-daniel.thompson@linaro.org>
Message-ID: <537F624F.2030401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/05/14 14:57, Daniel Thompson wrote:
> +
> +	if (chip->irq_eoi)
> +			chip->irq_eoi(irq_data);
> +}
> +
Looks like an extra tab here..
