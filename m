From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 04 Apr 2013 07:52:33 +0200
Subject: [PATCH v2 0/6] clk: sunxi: gates support
In-Reply-To: <20130403214545.3383.95826@quantum>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
 <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
 <20130403214545.3383.95826@quantum>
Message-ID: <515D1521.60501@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike

Le 03/04/2013 23:45, Mike Turquette a ?crit :
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

1, 6 and 7 are changes on the clock driver in itself that depends on the
patches you have in your tree, so I guess you should take them through
your tree.

2,3 and 5 are dt patches, so I'll take them, and patch 4 has already
been applied by LinusW.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
