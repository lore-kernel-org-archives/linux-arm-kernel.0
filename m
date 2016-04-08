From: al.stone@linaro.org (Al Stone)
Date: Fri, 8 Apr 2016 08:28:08 -0600
Subject: [PATCH v3] ARM64: ACPI: Update documentation for latest
 specification version
In-Reply-To: <20160408131208.GE23750@arm.com>
References: <1459210002-3387-1-git-send-email-al.stone@linaro.org>
 <5706D63F.7050107@redhat.com> <20160408131208.GE23750@arm.com>
Message-ID: <5707BFF8.3030704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2016 07:12 AM, Will Deacon wrote:
> On Thu, Apr 07, 2016 at 03:50:55PM -0600, Al Stone wrote:
>> On 03/28/2016 06:06 PM, Al Stone wrote:
>>> The ACPI 6.1 specification was recently released at the end of January
>>> 2016, but the arm64 kernel documentation for the use of ACPI was written
>>> for the 5.1 version of the spec.  There were significant additions to the
>>> spec that had not yet been mentioned -- for example, the 6.0 mechanisms
>>> added to make it easier to define processors and low power idle states,
>>> as well as the 6.1 addition allowing regular interrupts (not just from
>>> GPIO) be used to signal ACPI general purpose events.
>>>
>>> This patch reflects going back through and examining the specs in detail
>>> and updating content appropriately.  Whilst there, a few odds and ends of
>>> typos were caught as well.  This brings the documentation up to date with
>>> ACPI 6.1 for arm64.
>>>
>>> Changes for v3:
>>>    -- Clarify use of _LPI/_RDI (Vikas Sajjan)
>>>    -- Whitespace cleanup as pointed out by checkpatch
>>>
>>> Changes for v2:
>>>    -- Clean up white space (Harb Abdulhahmid)
>>>    -- Clarification on _CCA usage (Harb Abdulhamid)
>>>    -- IORT moved to required from recommended (Hanjun Guo)
>>>    -- Clarify IORT description (Hanjun Guo)
>>>
>>> Signed-off-by: Al Stone <al.stone@linaro.org>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> ---
>>>  Documentation/arm64/acpi_object_usage.txt | 446 ++++++++++++++++++++++--------
>>>  Documentation/arm64/arm-acpi.txt          |  28 +-
>>>  2 files changed, 357 insertions(+), 117 deletions(-)
>>> [snip...]
>>
>> Ping?  Any further comments or is this good to go?
> 
> It would be nice to see an ack from some other ACPI people, if that's
> possible. Which tree were you planning to merge this through?
> 
> Will
> 

Agreed.  I was hoping the ping would elicit some of that.

I assumed this would go through the arm64 tree since it's pretty specific
to the architecture.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
