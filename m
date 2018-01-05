From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 5 Jan 2018 22:22:43 +0800
Subject: [PATCH 4/6] ARM64: dts: meson-axg: uart: Add the pinctrl info
 description
In-Reply-To: <1515148123.5048.22.camel@baylibre.com>
References: <20180105095621.196472-1-yixun.lan@amlogic.com>
 <20180105095621.196472-5-yixun.lan@amlogic.com>
 <1515148123.5048.22.camel@baylibre.com>
Message-ID: <f10b2e0e-4e65-42af-5358-f107aa631132@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2018 06:28 PM, Jerome Brunet wrote:
> On Fri, 2018-01-05 at 17:56 +0800, Yixun Lan wrote:
>> Describe the pinctrl info for the UART controller which 
.

>> +				uart_a_cts_rts_pins: uart_a_cts_rts {
>> +					mux {
>> +						groups = "uart_ctx_a",
> 
> uart_ctx_a does not exist in pinctrl
> 
sorry, it's a typo, it's uart_cts_a

em. end of the Friday is really bad time for me to compose the patches..


>> +							"uart_rts_a";
>> +						function = "uart_a";
>> +					};
>> +				};
>> +
>> +				uart_b_x_pins: uart_b_x {
>> +					mux {
>> +						groups = "uart_tx_b_x",
>> +							"uart_rx_b_x";
>> +						function = "uart_b";
>> +					};
>> +				};
>> +
>> +				uart_b_x_cts_rts_pins: uart_b_x_cts_rts {
>> +					mux {
>> +						groups = "uart_cts_b_x",
>> +							"uart_rts_b_x";
>> +						function = "uart_b";
>> +					};
>> +				};
>> +
>> +				uart_b_z_pins: uart_b_z {
>> +					mux {
>> +						groups = "uart_tx_b_z",
>> +							"uart_rx_b_z";
>> +						function = "uart_b";
>> +					};
>> +				};
>> +
>> +				uart_b_z_cts_rts_pins: uart_b_z_cts_rts {
>> +					mux {
>> +						groups = "uart_cts_b_z",
>> +							"uart_rts_b_z";
>> +						function = "uart_b";
>> +					};
>> +				};
>> +
>> +				uart_ao_b_z_pins: uart_ao_b_z {
>> +					mux {
>> +						groups = "uart_ao_tx_b_z",
>> +							"uart_ao_rx_b_z";
>> +						function = "uart_ao_b_groupz";
> 
> "uart_ao_b_groupz" function does not exist in pinctrl
typo, uart_ao_b_gpioz

> 
.
