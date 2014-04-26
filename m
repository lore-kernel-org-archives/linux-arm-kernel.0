From: t.dakhran@gmail.com (Tarek Dakhran)
Date: Sat, 26 Apr 2014 19:31:17 +0400
Subject: [PATCH v8 3/3] ARM: dts: Add initial device tree support for
 EXYNOS5410
In-Reply-To: <535B9B7E.4090802@gmail.com>
References: <1397459860-21869-1-git-send-email-t.dakhran@samsung.com>
 <1397459860-21869-4-git-send-email-t.dakhran@samsung.com>
 <535B9B7E.4090802@gmail.com>
Message-ID: <CANhyOUdPwFL1fjCtrSkzfkG0uWi4Ke7tTg1__cXhjLc8Dvu3jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Will be done in next version.

Best regards,
    Tarek

On Sat, Apr 26, 2014 at 3:41 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi,
>
> Since I've started enforcing reference-based DT syntax due to multiple
> advantages over the plain full-tree based one, you should do the same for
> your dts/i files. You can take the series adding support for Exynos5260 as
> an example:
>
> http://thread.gmane.org/gmane.linux.kernel.samsung-soc/29360
>
> Best regards,
> Tomasz
>
> On 14.04.2014 09:17, Tarek Dakhran wrote:
>>
>> Add initial device tree nodes for EXYNOS5410 SoC and SMDK5410 board.
>>
>> Signed-off-by: Tarek Dakhran <t.dakhran@samsung.com>
>> Signed-off-by: Vyacheslav Tyrtov <v.tyrtov@samsung.com>
>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>> ---
>>   arch/arm/boot/dts/Makefile                |    1 +
>>   arch/arm/boot/dts/exynos5410-smdk5410.dts |   65 ++++++++++++++
>>   arch/arm/boot/dts/exynos5410.dtsi         |  140
>> +++++++++++++++++++++++++++++
>>   3 files changed, 206 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/exynos5410-smdk5410.dts
>>   create mode 100644 arch/arm/boot/dts/exynos5410.dtsi
>>
>
