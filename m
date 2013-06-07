From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 07 Jun 2013 13:50:11 +0200
Subject: [PATCH v4 0/2] ARM: PJ4B: fix for 3.10-rc
In-Reply-To: <20130607101234.GF3132@mudshark.cambridge.arm.com>
References: <1370599460-9947-1-git-send-email-gregory.clement@free-electrons.com>
 <20130607101234.GF3132@mudshark.cambridge.arm.com>
Message-ID: <51B1C8F3.5090509@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2013 12:12 PM, Will Deacon wrote:
> On Fri, Jun 07, 2013 at 11:04:18AM +0100, Gregory CLEMENT wrote:
>> Hello,
>>
>> This path set allows to fix one errata for PJ4B CPUs.
>>
>> Without this the Armada 370 based board can't boot anymore since
>> 3.10-rc1. So this one really need to be applied on 3.10-rc.
>>
>> As they were pending question for the second one, I preferred to keep
>> it apart awaiting the answers from the Marvell engineer.
>>
>> Both of the patches of this series are needed to fix the issue. Indeed
>> if the CPU is not recognized as a PJ4B then the fix is not applied.
> 
> Reviewed-by: Will Deacon <will.deacon@arm.com>
> 

Thanks for your review.

> Does this need a CC stable as well? I know that my TLB patch tickled it, but
> that's not to say it couldn't occur with particular configurations of older
> kernels.

Well according to stable_kernel_rules.txt " It must fix a real bug
that bothers people (not a, "This could be a problem..." type thing)."

So I am not sure that it should go to stable. But it is arguable.
Then I will add the Cc: <stable@vger.kernel.org> flag to the patches
when I will submit them to Russell pacth system.

Gregory
