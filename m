From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Wed, 03 Apr 2013 19:13:42 -0300
Subject: [PATCH v2 0/6] clk: sunxi: gates support
In-Reply-To: <20130403214545.3383.95826@quantum>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
 <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
 <20130403214545.3383.95826@quantum>
Message-ID: <515CA996.6040300@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

El 03/04/13 18:45, Mike Turquette escribi?:
> Quoting Emilio L?pez (2013-03-27 14:20:36)
>> Hi,
>>
>> This patchset adds support for the main sunxi gates; namely, those found 
>> on AXI, AHB, APB0 and APB1 clocks. The series depends on Maxime's UART 
>> rework and on the basic sunxi clock driver by me.
>>
>> Patches 1 and 2 implement the actual gate support, and patch 3 switches 
>> the UARTs to use the correct gates now that they are available.
>>
>> Patch 4 and 5 add clock support to our pinctrl driver, as we need to 
>> keep the pio clock running for gpio to work.
>>
>> Patch 6 drops the ignore flags; now that we have actual clock users that 
>> will keep the important clocks running.
>>
>> Patch 7 is an unrelated oneliner to remove an unnecesary kmalloc call.
>>
>> The main changes from v1 are renamed compatible strings and a clarification
>> on the documentation, see each individual patch for more details.
>>
> 
> Hi Emilio,
> 
> Which tree(s) did you want these patches to go through?

The rest of the clk driver is on your tree, so I think 1, 6 and 7 should
go through there too, unless Maxime has any objection.

Thanks,

Emilio
