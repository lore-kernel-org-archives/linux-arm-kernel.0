From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 17 Jan 2017 09:19:43 +0100
Subject: [PATCH v2 0/8] ARM: dts: Switch to new DSA binding
In-Reply-To: <61c15ec6-6c0d-7865-d140-dba4ca3657a4@gmail.com> (Florian
 Fainelli's message of "Mon, 16 Jan 2017 17:30:38 -0800")
References: <20170105192957.14304-1-f.fainelli@gmail.com>
 <61c15ec6-6c0d-7865-d140-dba4ca3657a4@gmail.com>
Message-ID: <87d1fm6qu8.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,
 
 On mar., janv. 17 2017, Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 01/05/2017 11:29 AM, Florian Fainelli wrote:
>> Hi all,
>> 
>> This patch series converts the in-tree users to utilize the new (relatively)
>> DSA binding that was introduced with commit 8c5ad1d6179d ("net: dsa: Document
>> new binding"). The legacy binding node is kept included, but is marked
>> disabled.
>> 
>> Changes in v2:
>> 
>> - patch 1: Use an hexadecimal reg property
>> - patch 2: fixed the subject
>> - patch 3: s/okay/disabled/ for the legacy DSA node
>> - patches 7/8: fixed a stray whitespace
>> 
>> In about 2-3 releases we may consider removing the old DSA binding entirely
>> from the kernel.
>
> Gregory, are you going to take this for 4.11? Thanks

it is my intend but I am waiting for the feedback from Andrew.

Gregory

>
>> 
>> Thank you!
>> 
>> Florian Fainelli (8):
>>   ARM: dts: armada-370-rd: Utilize new DSA binding
>>   ARM: dts: armada-385-linksys: Utilize new DSA binding
>>   ARM: dts: armada-388-clearfog: Utilize new DSA binding
>>   ARM: dts: armada-xp-linksys-mamba: Utilize new DSA binding
>>   ARM: dts: kirkwood-dir665: Utilize new DSA binding
>>   ARM: dts: kirkwood-linksys-viper: Utilize new DSA binding
>>   ARM: dts: kirkwood-mv88f6281gtw-ge: Utilize new DSA binding
>>   ARM: dts: kirkwood-rd88f6281: Utilize new DSA binding
>> 
>>  arch/arm/boot/dts/armada-370-rd.dts            | 44 +++++++++++++++++
>>  arch/arm/boot/dts/armada-385-linksys.dtsi      | 52 ++++++++++++++++++++-
>>  arch/arm/boot/dts/armada-388-clearfog.dts      | 65 ++++++++++++++++++++++++++
>>  arch/arm/boot/dts/armada-xp-linksys-mamba.dts  | 53 +++++++++++++++++++++
>>  arch/arm/boot/dts/kirkwood-dir665.dts          | 49 +++++++++++++++++++
>>  arch/arm/boot/dts/kirkwood-linksys-viper.dts   | 49 +++++++++++++++++++
>>  arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 49 +++++++++++++++++++
>>  arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts    | 11 +++++
>>  arch/arm/boot/dts/kirkwood-rd88f6281.dtsi      | 44 +++++++++++++++++
>>  9 files changed, 415 insertions(+), 1 deletion(-)
>> 
>
>
> -- 
> Florian

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
