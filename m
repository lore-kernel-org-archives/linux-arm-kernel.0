From: eric.miao@linaro.org (Eric Miao)
Date: Thu, 22 Sep 2011 20:19:26 +0800
Subject: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53
	platforms
In-Reply-To: <CAODfWeFPwUa++=Bz6503KJS9dNhmkjNuWF_g==MaFKydqRRX3A@mail.gmail.com>
References: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
	<CAODfWeEm8bkySXxb1qopbH1VMu-V+33k5x+0+qjABzesT0amOA@mail.gmail.com>
	<CAJNCFV+XFGEba1J2dXDa4YVwqduAPV5y=5JYEXAZ0uv+S60vvw@mail.gmail.com>
	<CAODfWeEueF45_yvPV5Zxbva6K2gEfKZbY2qoqySYFPZWnSgLsg@mail.gmail.com>
	<CAJNCFVLP7gA_7vBjwVNkQaSg8LZ4hROLdNCx8SBVah=F1ptrhQ@mail.gmail.com>
	<CAODfWeHTRuFZtnYZOD-mFonyjBvjhid4=0=a_mYXdjXAOQYejA@mail.gmail.com>
	<CAMPhdO-f2RHtZ0RdV_wGZvohMT85Q3JzTePaD9w73shGpWkP6g@mail.gmail.com>
	<CAODfWeFPwUa++=Bz6503KJS9dNhmkjNuWF_g==MaFKydqRRX3A@mail.gmail.com>
Message-ID: <CAMPhdO98U2jJ24S=NDXBRGg013eAf8Q4mL02ySiWGOrXBAJVmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 5:30 PM, Hector Oron <hector.oron@gmail.com> wrote:
> Hello,
>
> ?Apologies for late reply.
>
> 2011/9/6 Eric Miao <eric.miao@linaro.org>:
>> On Tue, Sep 6, 2011 at 1:46 AM, Hector Oron <hector.oron@gmail.com> wrote:
>>> 2011/9/1 Richard Zhu <richard.zhu@linaro.org>:
>
>>> Here is my complete dmesg. The system seems to work fine, it is a
>>> 1.0TB WD10TPVT SATA disk in a case which provides eSATA and connected
>>> to mx53 LOCO with eSATA-to-SATA cable.
>
>> Is it possible that it's caused by this converter? Do you have a separate
>> SATA power supply that could help test the disk directly connected to
>> mx53loco?
>
> I think I had a bad configuration setup for my kernel. I have rebuilt
> 3.1.0-rc6 from Sascha's master git with this patches and now SATA is
> working properly I do not see any issue as I did. So, from my side all
> is OK now, and I assume I had some missing or conflicting module
> setup.
>
> Kind regards and apologies for inconveniences,

That's great, Herton. Can we take it as a Tested-by?

> --
> ?H?ctor Or?n ?-.. . -... .. .- -. ? -.. . ...- . .-.. --- .--. . .-.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
