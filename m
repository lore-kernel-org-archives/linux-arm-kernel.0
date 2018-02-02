From: david@lechnology.com (David Lechner)
Date: Fri, 2 Feb 2018 11:50:23 -0600
Subject: [PATCH v6 17/41] dt-bindings: clock: Add bindings for DA8XX
 CFGCHIP clocks
In-Reply-To: <572e31a2-ac18-512b-03bb-82fffcf4d228@ti.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-18-git-send-email-david@lechnology.com>
 <572e31a2-ac18-512b-03bb-82fffcf4d228@ti.com>
Message-ID: <26fd0f01-ed14-6544-7443-e88c69ca9acb@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/2018 12:20 AM, Sekhar Nori wrote:
> On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
>> +EMIFA clock source (ASYNC1)
>> +---------------------------
>> +Required properties:
>> +- compatible: shall be "ti,da850-async1-clksrc".
>> +- #clock-cells: from common clock binding; shall be set to 0.
>> +- clocks: phandles to the parent clocks corresponding to clock-names
>> +- clock-names: shall be "pll0_sysclk3", "div4.5"
> 
> Is this clock really referred to as aysnc1 in documentation? I don't get
> hits for async1 in OMAP-L138 TRM.
> 

It looks like it is only called ASYNC1 in the datasheet, not the TRM.

Table 6-5. Maximum Internal Clock Frequencies at Each Voltage Operating
Point
