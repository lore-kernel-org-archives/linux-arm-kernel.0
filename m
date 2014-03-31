From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 31 Mar 2014 11:12:33 -0700
Subject: [PATCH v4] ARM: mm: fix reporting of read-only PMD bits
In-Reply-To: <CAGXu5j+GokV1MKv4Otb0AGt4Xvm8WXMLaOvGUUX+BJpo7Myg9g@mail.gmail.com>
References: <20140323042050.GA15181@www.outflux.net>
 <CAGXu5j+GokV1MKv4Otb0AGt4Xvm8WXMLaOvGUUX+BJpo7Myg9g@mail.gmail.com>
Message-ID: <5339B011.7070006@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/28/2014 11:45 AM, Kees Cook wrote:
> On Sat, Mar 22, 2014 at 9:20 PM, Kees Cook <keescook@chromium.org> wrote:
>> On non-LPAE ARMv6+, read-only PMD bits are defined with the combination
>> "PMD_SECT_APX | PMD_SECT_AP_WRITE". Adjusted the bit masks to correctly
>> report this.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> v4:
>>  - clean up defines for CPU versions; Rob Herring.
>> v3:
>>  - check for pre-v6 CPUs on the page table report.
>> v2:
>>  - reorder bits, suggested by Olof.
> 
> Can anyone give this a test or ack? I've done build tests for all CPU
> combinations, and runtime tests on v6 and LPAE.
> 
> Thanks!
> 
> -Kees
> 

You are welcome to add

Tested-by: Laura Abbott <lauraa@codeaurora.org>

Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
