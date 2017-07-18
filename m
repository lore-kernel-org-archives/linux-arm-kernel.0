From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Tue, 18 Jul 2017 14:43:45 +0000
Subject: [PATCH v2 0/7] staging: fsl-mc: make the driver compile on other
 architectures
In-Reply-To: <CAK8P3a39fpEHwCvR3TOL8u8W7TORSNpw27xwma70sxi-VfXhyA@mail.gmail.com>
References: <20170718133723.12709-1-laurentiu.tudor@nxp.com>
 <CAK8P3a39fpEHwCvR3TOL8u8W7TORSNpw27xwma70sxi-VfXhyA@mail.gmail.com>
Message-ID: <596E1EA0.3040002@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 07/18/2017 05:26 PM, Arnd Bergmann wrote:
> On Tue, Jul 18, 2017 at 3:37 PM,  <laurentiu.tudor@nxp.com> wrote:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> Apart from a small change (first patch) which adds a missing comment,
>> this series make the bus driver compile on other architectures, as per
>> GregKH comment [1].
>> Compiled tested on:
>>   - booke powerpc (corenet{32,64}_smp_defconfig) with this ppc patch [2]
>>   - x86 (i386_defconfig, x86_64_defconfig, needs CONFIG_OF)
>>   - arm64 (defconfig)
>>
>> [1] https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Flinux-driver-devel%2Fmsg100585.html&data=01%7C01%7Claurentiu.tudor%40nxp.com%7C2564747d26964ed5b3f408d4cde8f442%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0&sdata=Dz8vvLzQESel2UTXrhQ3JZyNhx5VhUdj6%2BE6TDLnXmc%3D&reserved=0
>> [2] https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.ozlabs.org%2Fpatch%2F789474%2F&data=01%7C01%7Claurentiu.tudor%40nxp.com%7C2564747d26964ed5b3f408d4cde8f442%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0&sdata=%2FiGSaa4j60INeTWEbT926iEIAtya6tqIiIoQN1yFbmA%3D&reserved=0
>
> Looks good overall. With the two minor questions addressed
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>

Thanks for the ack. I'll mention it the next version.

---
Thanks & Best Regards, Laurentiu
