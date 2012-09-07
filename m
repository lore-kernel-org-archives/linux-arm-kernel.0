From: koba@kmckk.co.jp (Tetsuyuki Kobayashi)
Date: Fri, 07 Sep 2012 10:50:47 +0900
Subject: [PATCH v3 0/2] ARM: shmobile: enable PMU(Performance Monitoring
 Unit)
In-Reply-To: <20120906112109.GG858@mudshark.cambridge.arm.com>
References: <50487370.6000409@kmckk.co.jp>
 <1346930047-9541-1-git-send-email-koba@kmckk.co.jp>
 <20120906112109.GG858@mudshark.cambridge.arm.com>
Message-ID: <504952F7.6090906@kmckk.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Will
Hi, Simon

(2012/09/06 20:21), Will Deacon wrote:
> On Thu, Sep 06, 2012 at 12:14:05PM +0100, Tetsuyuki Kobayshi wrote:
>> From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
>>
>> Hello, Will
>
> Hi,
>
> Thanks for updating the patches.
>
>> Could you apply this patch set to your pmu/cleanup branch on arm-soc?
>
> Actually, it's better if you just base your branch against that one when you
> send it to arm-soc for merging. That way, other SoCs can also develop
> against that branch without having to worry about each other.
>
I see.
I thought that removing ARM_PMU_DEVICE_CPU depends on your pmu/cleanup 
branch, but I found it does not.
I verified this v3 patch can apply cleanly to soc branch on renesus.git
and works fine.

Simon-san, could you apply this v3 patch to soc branch after review ?
