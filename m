From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 08 Jan 2015 08:42:37 -0800
Subject: [PATCH v15 11/11] KVM: arm/arm64: Add support to dissolve huge PUD
In-Reply-To: <20150108113221.GK21092@cbox>
References: <1418628488-3696-1-git-send-email-m.smarduch@samsung.com>
 <1418628488-3696-12-git-send-email-m.smarduch@samsung.com>
 <20150107130514.GD21092@cbox> <54ADF2F6.8060906@samsung.com>
 <20150108113221.GK21092@cbox>
Message-ID: <54AEB37D.8090906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2015 03:32 AM, Christoffer Dall wrote:
[...]
>> Not sure myself what's the vision for PUD support.
>>
> 
> with 4-level paging on aarch64, we use PUDs but we haven't added any
> code to insert huge PUDs (only regular ones) on the stage-2 page tables,
> even if the host kernel happens to suddenly support huge PUDs for the
> stage-1 page tables, which is what I think we were trying to address.
> 
> 
> So I really think we can drop this whole patch.  As I said, really sorry
> about this one!
No problem I'll drop this patch.
> 
> -Christoffer
> 
