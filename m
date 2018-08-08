From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 8 Aug 2018 11:28:59 +0100
Subject: [PATCH] arm64: dts: hisilicon: Add missing clocks property for
 CPUs
In-Reply-To: <20180731072414.vymng6k5uamgmyhi@vireshk-i7>
References: <6de0dde994326b3fdc2b746e22fdf1afe18067d2.1532315177.git.viresh.kumar@linaro.org>
 <20180731072414.vymng6k5uamgmyhi@vireshk-i7>
Message-ID: <5B6AC5EB.3030808@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On 2018/7/31 8:24, Viresh Kumar wrote:
> On 23-07-18, 08:36, Viresh Kumar wrote:
>> The clocks property should either be present for all the CPUs of a
>> cluster or none. If these are present only for a subset of CPUs of a
>> cluster then things will start falling apart as soon as the CPUs are
>> brought online in a different order. For example, this will happen
>> because the operating system looks for such properties in the CPU node
>> it is trying to bring up, so that it can register a cooling device.
>>
>> Add missing clocks property.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 7 +++++++
>>  1 file changed, 7 insertions(+)
> 
> @Wei: Can you please apply this one as well ?

Sorry for the late reply!
I will apply it after 4.19-rc1 released.
Thanks!

Best Regards,
Wei
