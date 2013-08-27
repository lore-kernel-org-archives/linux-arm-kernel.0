From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 26 Aug 2013 19:09:21 -0700
Subject: [ARM ATTEND] catching up on exploit mitigations
In-Reply-To: <20130826195632.GG10783@sirena.org.uk>
References: <CAGXu5jKv9Vt+Hu0mFYaxggLLDZ46U3KR9MKegUoHH8StXCkBtQ@mail.gmail.com>
 <5209BB6F.2000208@codeaurora.org> <20130826195632.GG10783@sirena.org.uk>
Message-ID: <521C0A51.2000908@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/26/2013 12:56 PM, Mark Brown wrote:
> On Mon, Aug 12, 2013 at 09:51:59PM -0700, Laura Abbott wrote:
>> On 7/30/2013 12:05 PM, Kees Cook wrote:
>
>>> - RO and W^X kernel page table protections (similar to x86's
>>> DEBUG_RODATA and DEBUG_SET_MODULE_RONX; it's not clear to me how much
>>> LPAE and PXN is already handling this, if at all)
>
>> We've had support for RO/NX on our tree for a while. I'm interested
>> in attending the summit to share what we've done and to see how much
>> of it could be mainlined.
>
> Is that related to the code that Google have in their tree?

It's 'related' in that it covers some of the same use cases but the two 
were developed independently as far as I know.

Thanks,
Laura



-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
