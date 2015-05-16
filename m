From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 16 May 2015 12:39:21 +0900
Subject: [GIT PULL 4/5] Samsung arm64 DT updates for v4.1
In-Reply-To: <CAGTfZH3bzjvVLH2HALDTLUf0MzibeH7sfFJh1n=dyuitYmUw_A@mail.gmail.com>
References: <555248E5.6010709@kernel.org>
 <CAGTfZH3bzjvVLH2HALDTLUf0MzibeH7sfFJh1n=dyuitYmUw_A@mail.gmail.com>
Message-ID: <5556BBE9.6030007@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/15 22:56, Chanwoo Choi wrote:
> Hi Kukjin,

[...]

>> As you know, the arm64-exynos5433 couldn't be sent to upstream during
>> previous merge window because it cannot be built without other stuff
>> such as board DT file. I think, you need to post its regarding board DT
>> file, I could test the exynos5433 series in my side with smdk5433 dt
>> file though. Maybe as you know, I have no plan to upstream the smdk5433
>> DT file because it will not be used outside of Samsung S.LSI.
> 
> Thanks for your test about Exynos5433 patch-set.
> But, I cannot send the DTS file for Exynos5433 right now.
> On the next, I'll send the Exynos5433's patchset and board dts file.
> 
OK, I see. I think, maybe you can make a patch for board DT file based
on v4.2-next/dt64-samsung branch in samsung tree.

Thanks,
Kukjin
