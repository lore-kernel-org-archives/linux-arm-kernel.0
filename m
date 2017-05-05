From: jcm@redhat.com (Jon Masters)
Date: Fri, 5 May 2017 11:33:47 -0400
Subject: [PATCH v3 3/7] ACPICA: IORT: Add Cavium ThunderX2 SMMUv3 model
 definition.
In-Reply-To: <20170505145800.GG14111@arm.com>
References: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
 <1493986091-30521-4-git-send-email-gakula@caviumnetworks.com>
 <330d0438-f9ed-ef65-8ffd-d556d149b4e1@linaro.org>
 <6b04ab17-449f-74e0-72f4-b5a9bc0639d8@gmail.com>
 <20170505145800.GG14111@arm.com>
Message-ID: <c4b72ee7-17ff-45f1-02a2-ec9f27232933@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2017 10:58 AM, Will Deacon wrote:
> On Fri, May 05, 2017 at 07:56:17AM -0700, David Daney wrote:
>> On 05/05/2017 06:53 AM, Hanjun Guo wrote:
>>> On 2017/5/5 20:08, Geetha sowjanya wrote:
>>>> From: Linu Cherian <linu.cherian@cavium.com>

>>>> +#define ACPI_IORT_SMMU_V3_CAVIUM_CN99XX 0x00000002 /* Cavium ThunderX2
>>>> SMMUv3 */
>>>
>>> There are some other model numbers in the unreleased spec,
>>> I think we need to wait for the updated IORT spec to
>>> be released.

Indeed. I've synced with the author on this and he's got it in hand.

>> ... or if we are fairly confident that the identifier will not need to
>> change, we can merge this as is and establish a de facto specification that
>> the Real IORT specification will then be forced to follow.

Can't do that - this always causes trouble ;) But if there's any delay
I'll ask that the IDs at least be listed somewhere public or something.

>> Is there anything other than bureaucratic inertia holding up the real
>> specification?
> 
> My understanding is that IORT is going to be published imminently (i.e.
> before the next kernel release), so it makes sense to wait rather than fork
> the spec.

Let's track this and get the updated patches posted next week once the
new ID drops. Meanwhile, I suggest reviewing them as-is for other
issues. I'm tracking this for internal purposes and require this to be
upstream asap so I'll be sitting on this thread for updates ;)

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
