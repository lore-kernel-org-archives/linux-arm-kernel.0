From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 19 Apr 2017 15:59:20 +0100
Subject: [GIT PULL] arm64: dts: hisilicon dts updates for v4.12
In-Reply-To: <20170419132420.GK29219@localhost>
References: <58EBA861.2010809@hisilicon.com> <20170419132420.GK29219@localhost>
Message-ID: <58F77B48.7000000@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 2017/4/19 14:24, Olof Johansson wrote:
> On Mon, Apr 10, 2017 at 04:44:33PM +0100, Wei Xu wrote:
>> Hi Arnd, Hi Olof, Hi Kevin,
>>
>> Please help to pull the following changes.
>> Thanks!
>>
>> Best Regards,
>> Wei
>>
>> ---
>> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
>>
>>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
>>
>> are available in the git repository at:
>>
>>   git://github.com/hisilicon/linux-hisi.git tags/hisi-arm64-dt-for-4.12
>>
>> for you to fetch changes up to d4e1eaeee56894f45d0093f9d432be0c868f7c4c:
>>
>>   arm64: dts: hisi: add pinctrl dtsi file for HiKey960 development board (2017-04-10 23:34:26 +0800)
>>
>> ----------------------------------------------------------------
>> ARM64: DT: Hisilicon SoC DT updates for 4.12
>>
>> - Reset the hi6220 mmc hosts to avoid hang
>> - Add the binding for the hi3798cv200 SoC and the poplar board
>> - Add basic dts files to support the hi3798cv200 poplar board
>> - Enable the Mbigen, XGE, RoCE and SAS for the hip07 d05 board
>> - Add driver strength MACRO for the hi3660 SoC
>> - Add the pinctrl dtsi file for hikey960 board to configure the pins
> 
> Merged, thanks.

Thanks!

Best Regards,
Wei

> 
> 
> -Olof
> 
> .
> 
