From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 08 May 2014 19:37:24 +0200
Subject: [PATCH v8 1/3] ARM: EXYNOS: initial board support for exynos5260
 SoC
In-Reply-To: <0b4101cf613e$eb2d87d0$c1889770$@samsung.com>
References: <1397620738-14431-1-git-send-email-rahul.sharma@samsung.com>
 <1397620738-14431-2-git-send-email-rahul.sharma@samsung.com>
 <534E3803.5010404@gmail.com>
 <CAK9yfHztqGWhUJ=PNc7L-epu48PkEM6=v6JFDZ1n52NBeOUB8w@mail.gmail.com>
 <534E3AE7.10907@gmail.com> <00eb01cf5e7b$4eb9edf0$ec2dc9d0$@samsung.com>
 <CAPdUM4O3imVNv3A3K1uEkfohc-r668SC6mVZQRCO8N+waxyb4w@mail.gmail.com>
 <0b4101cf613e$eb2d87d0$c1889770$@samsung.com>
Message-ID: <536BC0D4.3000302@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 26.04.2014 13:01, Kukjin Kim wrote:
> Rahul Sharma wrote:
>>
>> Hi Kukjin,
>>
> Hi,
> 
>> Need this macro to enable build for clock driver.
>>
> I found it in your patch, "clk/exynos5260: add clock file for exynos5260".
> For consistency, I'm fine on this, if Tomasz has no objection me to pick
> this into samsung tree for the 5260 clock stuff
> "drivers/clk/samsung/Makefile".

Yes, this should go through Samsung tree, but let me prepare a branch
for you to pull from with all the necessary dependencies.

Best regards,
Tomasz
