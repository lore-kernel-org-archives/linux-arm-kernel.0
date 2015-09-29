From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 29 Sep 2015 17:33:16 +0100
Subject: [Xen-devel] [PATCH v4 00/20] xen/arm64: Add support for 64KB
 page in Linux
In-Reply-To: <560ABBFA.6070902@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
 <560ABBFA.6070902@citrix.com>
Message-ID: <560ABD4C.2020004@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On 29/09/15 17:27, David Vrabel wrote:
> On 07/09/15 16:33, Julien Grall wrote:
>>
>> A branch based on the latest xentip/for-linus-4.3 can be found here:
>>
>> git://xenbits.xen.org/people/julieng/linux-arm.git branch xen-64k-v4
> 
> This has too many conflicts with the
> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.4
> branch.
> 
> Please rebase.

I was about to send a new version rebased (no changes in it so far
except for rebasing purpose). I will do it on top of for-linus-4.4.
I will also include the swiotlb changes at the end as it was reviewed by
Stefano.

BTW, some of the patches should, strictly speaking, go via the block and
network subsystem. Although, they heavily depends on other patches in
this series. Would it be fine to send all through xentip?

Regards,

-- 
Julien Grall
