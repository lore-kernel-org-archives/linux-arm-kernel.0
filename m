From: m.smarduch@samsung.com (Mario Smarduch)
Date: Mon, 29 Sep 2014 14:03:37 -0700
Subject: [PATCH v11 6/6] arm: KVM: ARMv7 dirty page logging 2nd stage page
 fault
In-Reply-To: <20140929133509.GH3095@cbox>
References: <1411433690-8104-1-git-send-email-m.smarduch@samsung.com>
 <1411433690-8104-7-git-send-email-m.smarduch@samsung.com>
 <20140929133509.GH3095@cbox>
Message-ID: <5429C929.4080507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29/2014 06:35 AM, Christoffer Dall wrote:
> On Mon, Sep 22, 2014 at 05:54:50PM -0700, Mario Smarduch wrote:
>> This patch adds support for handling 2nd stage page faults during migration,
>> it disables faulting in huge pages, and dissolves huge pages to page tables.
>> In case migration is canceled huge pages may be used again.
>>
>>
>> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> 
> It seems here and in a bunch of the other patches you didn't apply my
> Reviewed-by tags.  Did you change the patches in other ways than
> addressed by the review comments?
> 
> Thanks,
> -Christoffer
> 
Christoffer,
 you comments and Hiabins were applied, no other changes.
Overlooked the acks/reviewed :(

Thanks,
- Mario
