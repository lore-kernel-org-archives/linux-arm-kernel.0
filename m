From: mmcclint@codeaurora.org (Matthew McClintock)
Date: Tue, 16 Feb 2016 14:43:18 -0600
Subject: [PATCH v3 5/6] dts: ipq4019: Add support for IPQ4019 DK01 board
In-Reply-To: <20160208224328.GB10791@codeaurora.org>
References: <1447975173-29485-1-git-send-email-mmcclint@qca.qualcomm.com>
 <1447975173-29485-6-git-send-email-mmcclint@qca.qualcomm.com>
 <20160208224328.GB10791@codeaurora.org>
Message-ID: <59152C1B-683F-417D-9C23-C6E3F53D7096@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Feb 8, 2016, at 4:43 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> On 11/19, Matthew McClintock wrote:
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK01.1";
>> +	compatible = "qcom,ipq4019";
>> +
>> +	clocks {
>> +                xo: xo {
>> +                        compatible = "fixed-clock";
>> +                        clock-frequency = <48000000>;
>> +                        #clock-cells = <0>;
>> +                };
>> +	};
> 
> Is there a reason the xo is here and the sleep clk is in the SoC
> dtsi file? Both are board clocks so I would think they would be
> added in the same place.

I?m a little bit confused and I wanted to confirm. I can see the xo clock is on the board itself. However, the sleep_clk is not, can you clarify why they would both be in the same place?

-M
