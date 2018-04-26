From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 26 Apr 2018 16:16:48 -0500
Subject: [PATCH v6 02/24] soc: qcom: Add APR bus driver
In-Reply-To: <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
Message-ID: <20180426211648.GB25699@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 10:45:44AM +0100, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds support toi APR bus (Asynchronous Packet Router) driver.
> ARP driver is made as a bus driver so that the apr devices can added removed
> more dynamically depending on the state of the services on the dsp.
> APR is used for communication between application processor and QDSP to
> use services on QDSP like Audio and others.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---

Acked-by: Andy Gross <andy.gross@linaro.org>
