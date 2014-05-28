From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 28 May 2014 11:42:00 -0700
Subject: [PATCH v6 4/4] add 2nd stage page fault handling during live
 migration
In-Reply-To: <5386232A.3050602@samsung.com>
References: <1400178451-4984-1-git-send-email-m.smarduch@samsung.com>
 <1400178451-4984-5-git-send-email-m.smarduch@samsung.com>
 <20140527201945.GD16428@lvm> <53853C2F.8080003@samsung.com>
 <20140528080957.GH16428@lvm> <5386232A.3050602@samsung.com>
Message-ID: <53862DF8.80709@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>emslot dirty_bitmap during and after write protect.
> 
>>
>> -Christoffer

Regarding huge pud that's causing some design problems, should huge PUD
pages be considered at all?

Thanks,
  Mario
>>
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 
