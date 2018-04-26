From: broonie@kernel.org (Mark Brown)
Date: Thu, 26 Apr 2018 12:39:11 +0100
Subject: [PATCH v6 02/24] soc: qcom: Add APR bus driver
In-Reply-To: <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
Message-ID: <20180426113911.GA21755@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 10:45:44AM +0100, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds support toi APR bus (Asynchronous Packet Router) driver.
> ARP driver is made as a bus driver so that the apr devices can added removed

What is the plan for getting this patch merged?  I think the only review
I've seen from maintainers thus far has been from Rob on the DT binding.
It's obviously going to be a dependency for everything else.

Also just saw ARP->APR there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180426/f9729d49/attachment.sig>
