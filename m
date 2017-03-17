From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 17 Mar 2017 17:01:22 +0200
Subject: [PATCHv2 1/9] Documentation: dt-bindings: Add binding
 documentation for TI clkctrl clocks
In-Reply-To: <20170317141813.GS20572@atomide.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <1489741781-12816-2-git-send-email-t-kristo@ti.com>
 <20170317141813.GS20572@atomide.com>
Message-ID: <2c30dc5a-203e-fbcf-229f-b4366dfe2774@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/17 16:18, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [170317 02:12]:
>> From: Tony Lindgren <tony@atomide.com>
>> +Example: Clock controller node on omap 4430:
>> +
>> +&cm2 {
>> +	l4per: cm at 1400 {
>> +		cm_l4per at 0 {
>> +			cm_l4per_clkctrl: clk at 20 {
>> +				compatible = "ti,clkctrl";
>> +				reg = <0x20 0x1b0>;
>> +				#clock-cells = <4>;
>> +			};
>> +		};
>> +	};
>> +};
>
> The #clock-cells = <4> is a typo left over from earlier revisions,
> care to update it to 2 like the binding doc specifies?

Ouch, yea I can update that. Will post along with v3 once more comments 
pour in.

-Tero
