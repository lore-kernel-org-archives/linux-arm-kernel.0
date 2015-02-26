From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 26 Feb 2015 20:39:48 +0100
Subject: [PATCH 0/8] Add proper support for Compulab CM-A510/SBC-A510
In-Reply-To: <54EF5E17.1070005@free-electrons.com>
References: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <54EF5E17.1070005@free-electrons.com>
Message-ID: <54EF7684.80409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.02.2015 18:55, Gregory CLEMENT wrote:
> On 17/02/2015 19:52, Sebastian Hesselbarth wrote:
>> This patch set improves current mainline support for the Compulab
>> CM-A510 System-on-Module (SoM) and its default Compulab SBC-A510
>> base board. Thanks to Gabriel Dobato who agreed to remote debug and
>> test the provided DT changes.
[...]
>> Sebastian Hesselbarth (8):
>>    i2c: mux-pinctrl: Rework to honor disabled child nodes
>>    devicetree: vendor-prefixes: Add CompuLab to known vendors
>>    ARM: dts: dove: Fix uart[23] reg property
>>    ARM: dts: dove: Always include gpio and interrupt-controller headers
>>    ARM: dts: dove: Add node labels for PCIe ports 0 and 1
>>    ARM: dts: dove: Add some more common pinctrl settings
>>    ARM: dts: dove: Add internal i2c multiplexer node
>>    ARM: dts: dove: Add proper support for Compulab CM-A510/SBC-A510
>
> Patches 3 to 6 applied on mvebu/dt
>
> If I understood well patches 7 and 8 depend on patch 1 which had not been
> taken yet.

Correct. Once I get a Tested-by from Stephen, I'll resend the 4
remaining patches.

Thanks,
   Sebastian
