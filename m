From: antoine.tenart@free-electrons.com (=?UTF-8?B?QW50b2luZSBUw6luYXJ0?=)
Date: Tue, 18 Mar 2014 09:43:30 +0100
Subject: [PATCH v3 1/3] ARM: dts: berlin2q: add the Marvell Armada 1500 pro
In-Reply-To: <20140318102435.2d29abc7@xhacker>
References: <1395068788-19786-1-git-send-email-antoine.tenart@free-electrons.com>	<1395068788-19786-2-git-send-email-antoine.tenart@free-electrons.com>
 <20140318102435.2d29abc7@xhacker>
Message-ID: <53280732.4060707@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

On 18/03/2014 03:24, Jisheng Zhang wrote:
>> +	sysclk: system-clock {
>> +		compatible = "fixed-factor-clock";
>> +		#clock-cells = <0>;
>> +		clocks = <&cpuclk>;
>> +		clock-multi = <1>;
>> +		clock-div = <3>;
>> +	};
>
> Can you please name it as twdclk to avoid confusion? On Berlin, sysclk is another
> clk rather than the clk for twd.

Sure, I'll change the name and send a v4.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
