From: ddaney@caviumnetworks.com (David Daney)
Date: Wed, 24 Feb 2016 10:07:44 -0800
Subject: [PATCH v3] arm64: Add workaround for Cavium erratum 27456
In-Reply-To: <20160224180626.GF12471@arm.com>
References: <1456272534-21692-1-git-send-email-ddaney.cavm@gmail.com>
 <20160224134016.GH28310@arm.com> <56CDB912.6000300@arm.com>
 <56CDF056.8020408@caviumnetworks.com> <20160224180626.GF12471@arm.com>
Message-ID: <56CDF170.30509@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2016 10:06 AM, Will Deacon wrote:
> On Wed, Feb 24, 2016 at 10:03:02AM -0800, David Daney wrote:
>> On 02/24/2016 06:07 AM, Marc Zyngier wrote:
>>> On 24/02/16 13:40, Will Deacon wrote:
>>>
>>> [...]
>>>
>>>> (and Catalin, if you pick this up, watch out for the conflicts in
>>>> cpufeature.h)
>>>
>>> Yup, that one is about to become a minefield (ARM64_HAS_NO_HW_PREFETCH,
>>> ARM64_HAS_UAO, ARM64_ALT_PAN_NOT_UAO and ARM64_HAS_VIRT_HOST_EXTN are
>>> already happily clashing into -next). But hey, the more the merrier! ;-)
>>>
>>
>> Would you like me to rebase it to for-next/core ?
>
> I think ARM64_HAS_VIRT_HOST_EXTN is in the KVM tree, so you're probably
> best off looking at linux-next and choosing your feature number based on
> that, whilst basing the patch on either for-next/core or mainline.
>

OK, I will do that now.

David.

> Will
>
