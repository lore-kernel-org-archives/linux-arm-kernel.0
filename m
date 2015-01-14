From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 14 Jan 2015 11:26:55 +0800
Subject: [GIT PULL]Hisilicon hip01 soc and development board updates for
 3.20
In-Reply-To: <20150113232304.GG15087@quad.lixom.net>
References: <54B38E24.6040901@hisilicon.com>
 <20150113232304.GG15087@quad.lixom.net>
Message-ID: <54B5E1FF.6090301@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/1/14 7:23, Olof Johansson wrote:
> Hi,
> 
> This is very close to inclusion, can I just ask you to make a few tweaks?
> 
> On Mon, Jan 12, 2015 at 05:04:36PM +0800, Wei Xu wrote:
>> Hi Arnd, Hi Olof, Hi Kevin, 
>>
>> Could you please help to merge the pull request of hisilicon hip01 soc for 3.20. 
>> Thanks!
>>
>> Best Regards,
>> Wei
>>
>> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
>>
>>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
>>
>> are available in the git repository at:
>>
>>   git://github.com/hisilicon/linux-hisi.git tags/hip01-for-3.20
>>
>> for you to fetch changes up to 3a1d691f244b54f59958e2294779ddc6905b1d8f:
>>
>>   ARM: hisi: enable smp for HiP01 (2015-01-12 15:48:16 +0800)
>>
>> ----------------------------------------------------------------
>> ARM: mach-hisi: Hisilicon hip01 soc and development board updates for 3.20
>>
>> - Add hip01 debug UART
>> - Add hip01 DT_MACHINE and ARCH_HIP01 configure item
>> - Add dts for Hisilicon hip01-ca9x2 board
>> - Enable ARCH_HIP01 in the hisi_defconfig and multi_v7_defconfig
>> - Add a common smp_prepares_cpus function
>> - Rename hix5hd2_secondary_startup to hisi_secondary_startup
>> - Enable smp for hip01
>>
>> ----------------------------------------------------------------
>> Wang Long (7):
>>       ARM: debug: add HiP01 debug uart
>>       ARM: hisi: enable HiP01 SoC
>>       ARM: dts: Add hip01-ca9x2 dts file
>>       ARM: config: enable ARCH_HIP01

Hi Olof, 

> Please split this patch out (at least the multi_v7 piece) and send it
> separately. You can send it just as a patch instead of as a single-patch pull
> request and we'll apply it directly.

OK.
I will ask Wang Long to send a separate patch about multi_v7 part.

>>       ARM: hisi: add a common smp_prepares_cpus function
> 
> This is just a rename, and the patch below calls it a rename -- you should do
> that here too.

OK.
I will change it in the next version of pull request.
Thanks!

Best Regards,
Wei

> 
> Thanks!
> 
> 
> -Olof
> 
> .
> 
