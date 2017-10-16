From: gengdj.1984@gmail.com (gengdongjiu)
Date: Mon, 16 Oct 2017 21:44:59 +0800
Subject: [PATCH v6 5/7] arm64: kvm: route synchronous external abort
 exceptions to el2
In-Reply-To: <59E49BB8.8080801@arm.com>
References: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
 <1503916701-13516-6-git-send-email-gengdongjiu@huawei.com>
 <59B17449.6010201@arm.com> <fb7da3e3-d0f7-7ac6-b088-888a563d7ee7@huawei.com>
 <59E49BB8.8080801@arm.com>
Message-ID: <CAMj-D2Bn8HUL=HJO-tysisVT4HSTZW0z-xY-1w1EsgPvShFooQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

>
>> Today I added the support to do some minimal emulation for
>> RAS-Error-Record registers, thanks
>> for the good suggestion.
>
> Where can I find this patch?
> I'd like to repost it as part of the SError_rework/RAS/IESB series: this is
> one
> of the bits KVM needs but I didn't touch as it looks like your updated
> version
> of this patch should cover it.

I have updated this patch according your suggestion that do some
emulation for the ERR* trap. and have verified it. but still not sent
it out. Tomorrow I will send it out for your review(now it is Chinese
midnight), if you think it is ok, you can add it as part of the
SError_rework/RAS/IESB series. thanks for your reminder and good
review comments.


>
>
> Thanks,
>
> James
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>
