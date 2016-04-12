From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 12 Apr 2016 10:18:45 +0100
Subject: [PATCH v2 2/5] ARM: STi: DT: STiH407: Enable Mailbox testing
 facility
In-Reply-To: <1458744223-12164-3-git-send-email-lee.jones@linaro.org>
References: <1458744223-12164-1-git-send-email-lee.jones@linaro.org>
 <1458744223-12164-3-git-send-email-lee.jones@linaro.org>
Message-ID: <570CBD75.5080401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On 23/03/16 14:43, Lee Jones wrote:
> This patch supplies a Client node to enable the Mailbox testing
> facility.  It will be used to send and receive messages from any
> given co-processor in order to test the STi Mailbox Controller
> driver.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   arch/arm/boot/dts/stih407-family.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index e6e34b4..9376c38 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -695,6 +695,12 @@
>   			status		= "okay";
>   		};
>
> +		mailbox_test {
> +			compatible = "mailbox_test";

IIRC, we changed this to "mailbox-text" ?

-- 
Regards,
Sudeep
