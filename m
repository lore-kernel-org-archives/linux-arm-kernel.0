From: srinivas.kandagatla@st.com (srinivas kandagatla)
Date: Mon, 2 Dec 2013 13:05:15 +0000
Subject: [PATCH v3 36/36] ARM: STi: Add support for the FSM Serial Flash
 Controller
In-Reply-To: <1385727565-25794-37-git-send-email-lee.jones@linaro.org>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-37-git-send-email-lee.jones@linaro.org>
Message-ID: <529C858B.1040601@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,
On 29/11/13 12:19, Lee Jones wrote:
> +		/* FSM */
> +		spifsm: spifsm at fe902000{
> +		        compatible         = "st,spi-fsm", "simple-bus";
"simple-bus" is redundant here.

> +		        reg                =  <0xfe902000 0x1000>;
> +		        reg-names          = "spi-fsm";
> +		        pinctrl-0          = <&pinctrl_fsm>;
> +
> +			st,syscfg	   = <&syscfg_rear>;
> +		        st,boot-device-reg = <0x958>;
> +		        st,boot-device-spi = <0x1a>;
> +
> +		        status = "okay";
> +		};


thanks,
srini
