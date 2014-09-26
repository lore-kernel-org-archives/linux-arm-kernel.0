From: zhangfei.gao@linaro.org (zhangfei)
Date: Fri, 26 Sep 2014 09:48:55 +0800
Subject: [GIT PULL][for 3.18]pull request for hisilicon hix5hd2 soc dt
 updates
In-Reply-To: <CAOesGMiPVg0aZsvXePyoQ49JPa+zPjz+SDwYSt6uDdHdPHsNcg@mail.gmail.com>
References: <5417D73E.8080309@hisilicon.com>
 <CAOesGMiPVg0aZsvXePyoQ49JPa+zPjz+SDwYSt6uDdHdPHsNcg@mail.gmail.com>
Message-ID: <5424C607.8060206@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/26/2014 08:46 AM, Olof Johansson wrote:

>>        ARM: dts: hix5hd2: add wdg node
>
> The watchdog commit causes build failures because:
>
> Error: arch/arm/boot/dts/hisi-x5hd2.dtsi:374.22-23 syntax error
>
> This is because HIX5HD2_WDG0_RST is not defined anywhere in the include files.
>
> You _really_ need to build test branches before you send them to us.
>
> I've reverted that particular patch now.
>

Sorry, it's my fault.
The watchdog patch is send out and go through Mike's tree.
Will resend this patch after clock patch has been merged.

Thanks
Zhangfei
