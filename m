From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 4 Jun 2013 23:31:00 +0800
Subject: [PATCH v2 6/6] ARM: hi3xxx: enable hi4511 with device tree
In-Reply-To: <4616948.RsjYUavD65@wuerfel>
References: <1370358317-12768-1-git-send-email-haojian.zhuang@linaro.org>
 <1370358317-12768-7-git-send-email-haojian.zhuang@linaro.org>
 <4616948.RsjYUavD65@wuerfel>
Message-ID: <CAD6h2NTbUOURJ4LbMGDoic93xzxAvH-in-jk9zrSzEUFPZMdJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 June 2013 23:20, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 04 June 2013 23:05:17 Haojian Zhuang wrote:
>> Enable Hisilicon Hi4511 development platform with device tree support.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
>
>>  arch/arm/boot/dts/Makefile          |    1 +
>>  arch/arm/boot/dts/hi3620.dtsi       | 1169 +++++++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/hi4511.dts        |  738 ++++++++++++++++++++++
>>  arch/arm/configs/multi_v7_defconfig |    1 +
>>  4 files changed, 1909 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/hi3620.dtsi
>>  create mode 100644 arch/arm/boot/dts/hi4511.dts
>
> I received the patch in private mail, but apparently the linux-arm-kernel
> list rejected it. It's probably too large, can you send out separate
> patches for the two files next time?
>
>         Arnd

OK. I'll split it into two files in next time.

Regards
Haojian
