From: julien.grall@linaro.org (Julien Grall)
Date: Wed, 18 Feb 2015 11:51:25 +0000
Subject: [PATCH 0/2] arm/arm64: Detect Xen support earlier
In-Reply-To: <1424259059.27775.17.camel@citrix.com>
References: <1423722898-16110-1-git-send-email-julien.grall@linaro.org>
 <1424259059.27775.17.camel@citrix.com>
Message-ID: <54E47CBD.7060002@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

On 18/02/2015 11:30, Ian Campbell wrote:
> On Thu, 2015-02-12 at 06:34 +0000, Julien Grall wrote:
>> Hello,
>>
>> This small patch series move the detection of running on Xen earlier. This is
>> required in order to support earlyprintk via Xen and selecting the preferred
>> console.
>
> Thanks for doing this, having all of the init done in an initcall (even
> a relatively early one) has been a niggle I've wanted address for ages,
> for exactly earlyprintk and preferred console reasons.
>
> I had a very minor comment on #1 but nonetheless both patches:
> Acked-by: Ian Campbell <ian.campbell@citrix.com>

Can I keep you ack on the first one with the __read_mostly dropped?

Regards,

-- 
Julien Grall
