From: anurupvasu@gmail.com (Anurup M)
Date: Fri, 24 Mar 2017 12:05:36 +0530
Subject: [PATCH v6 04/11] Documentation: perf: hisi: Documentation for
 HiP05/06/07 PMU event counting.
In-Reply-To: <20170321141222.GE22188@leverpostej>
References: <1489127259-112648-1-git-send-email-anurup.m@huawei.com>
 <20170321141222.GE22188@leverpostej>
Message-ID: <58D4BE38.1080003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review.

On Tuesday 21 March 2017 07:42 PM, Mark Rutland wrote:
> Hi,
>
> On Fri, Mar 10, 2017 at 01:27:39AM -0500, Anurup M wrote:
>
>> +HiP0x chips are encapsulated by multiple CPU and IO die's. The CPU die is
> Nit: that apostrophe shouldn't be there.

Ok. shall recheck and modify wherever applicable.

> [...]
>
>> +The current driver doesnot support sampling. so "perf record" is unsupported.
> Nit: spacing
>
> Otherwise, this looked fine.

Thanks. shall correct it.

> Thanks,
> Mark.
