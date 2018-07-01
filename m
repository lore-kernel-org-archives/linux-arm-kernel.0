From: sravanhome@gmail.com (Saravanan Sekar)
Date: Sun, 1 Jul 2018 18:53:31 +0200
Subject: [PATCH v2 0/3] Add clock driver for Actions S700 SoC
In-Reply-To: <153029392426.143105.1931235700216822088@swboyd.mtv.corp.google.com>
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
 <153029392426.143105.1931235700216822088@swboyd.mtv.corp.google.com>
Message-ID: <f35c3ea6-7f3f-17d5-f772-803674f18bdb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen


On 06/29/18 19:38, Stephen Boyd wrote:
> Quoting Saravanan Sekar (2018-06-28 12:18:02)
>> Changelog v2:
>> Fixed 0 day compilation warning
>> Modified existing dts Actions S900 clock bindings common to Actions
>> Soc family
>>
>> This patchset adds clock support for Actions Semi OWL series S700 SoC
>> with relevant clock bindings and device tree info.
>>
>> Changed the UART clock using CMU instance and changes are tested in
>> cubieboard7
>>
>> Thanks and regards,
>> Saravanan,
>> Parthiban
>>
>> Saravanan Sekar (3):
>>    arm64: dts: actions: Enable clock controller for S700
>>    clk: actions: Add S700 SoC clock support
>>    dt-bindings: clock: Modify Actions Soc clock bindings
> Normally this patch comes first, and then clk driver, and then dts bits.
> Also, the header file for the #define constants would be part of the
> bindings patch.

I will reorder the commit and split the patch
