From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 2 Apr 2018 11:39:46 +0530
Subject: [PATCH v5 08/13] ARM: dts: ipq4019: Add ipq4019-ap.dk07.1 common
 data
In-Reply-To: <20180327172034.GK1403@tuxbook-pro>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-9-git-send-email-sricharan@codeaurora.org>
 <20180327172034.GK1403@tuxbook-pro>
Message-ID: <b03a8001-e1b8-4340-55a8-53c81ae689ac@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/27/2018 10:50 PM, Bjorn Andersson wrote:
> On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
>> +#include "qcom-ipq4019.dtsi"
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK07.1";
>> +	compatible = "qcom,ipq4019";
> 
> The board should set these, so you shouldn't need to specify them here.
> And you should be able to find a more specific compatible for the board.
> 

 ok. agree. As mentioned earlier, will correct the compatible in all boards.

>> +
> [..]
>> +		qpic-nand at 79b0000 {
>> +			status = "ok";
> 
> No pinmux for the qpic on these boards?
> 
 clearly missed it and was lucky that bootloader was doing it in this case.
 Will add it.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
