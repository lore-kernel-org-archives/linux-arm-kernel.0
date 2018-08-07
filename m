From: gengdongjiu@huawei.com (gengdongjiu)
Date: Tue, 7 Aug 2018 14:37:36 +0800
Subject: [PATCH] arm64: clean the additional checks before calling
 ghes_notify_sea()
In-Reply-To: <20180806142623.GA15275@arm.com>
References: <1532638907-46129-1-git-send-email-gengdongjiu@huawei.com>
 <20180727100617.GB25592@arm.com>
 <CAMj-D2Ab9Txk27GDQbOy3X=Qup7BuA3sWSovsOpffpxe6UcBFQ@mail.gmail.com>
 <20180806142623.GA15275@arm.com>
Message-ID: <2c3baa9e-c647-01a9-cef6-eb61ba6c529c@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018/8/6 22:26, Will Deacon wrote:
>> Will,
>>      This patch will be applied, right? thanks
> I haven't queued it in the arm64 tree, since it touches include/acpi/ghes.h
> and you don't have an ack from the acpi folks. I acked it so that you could
> route it via the acpi tree without me holding you up.

Thanks the explanation.
yes, this patch touches the "include/acpi/ghes.h", I will repost this patch to let acpi
folks review it.


> 
> Will
> 
>>>> This cleanup is ever mentioned by Mark Rutland in [1]
