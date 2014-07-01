From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 1 Jul 2014 11:19:36 +0200
Subject: [PATCH 8/9 v2] coresight: adding basic support for Vexpress TC2
In-Reply-To: <1403892261-25026-9-git-send-email-mathieu.poirier@linaro.org>
References: <1403892261-25026-1-git-send-email-mathieu.poirier@linaro.org>
 <1403892261-25026-9-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <53B27D28.7090908@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.06.2014 20:04, mathieu.poirier at linaro.org wrote:
> From: Mathieu Poirier <mathieu.poirier@linaro.org>
>
> Support for the 2 PTMs, 3 ETMs, funnel, TPIU and replicator
> connected to the ETB are included.  Proper handling of the
> ITM and the replicator linked to it along with the CTIs
> and SWO are not included.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 174 +++++++++++++++++++++++++++++
>   1 file changed, 174 insertions(+)
>
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> index 15f98cb..390f2bb 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
...
> +	funnel {
> +		compatible = "arm,coresight-funnel", "arm,primecell";
...
> +			 * repicator but configured as par of the funnel.

Two typos here?

repicator -> replicator

as par -> as part

Best regards

Dirk
