From: slash.tmp@free.fr (Mason)
Date: Thu, 8 Oct 2015 20:37:23 +0200
Subject: [PATCH v4] twd: Don't set CLOCK_EVT_FEAT_C3STOP unconditionally
In-Reply-To: <20151008182254.GJ32532@n2100.arm.linux.org.uk>
References: <56123BD0.8010005@sigmadesigns.com>
 <56124035.6080107@sigmadesigns.com>
 <CACRpkdbWRU3UH6aJnqdcuzdh_-sE7ryhs0vBTUbbRDcJ7PWXLw@mail.gmail.com>
 <561247DF.1000308@sigmadesigns.com> <20151005103539.GC19064@leverpostej>
 <5612649C.5020401@sigmadesigns.com> <20151008171616.GG7275@leverpostej>
 <5616AA2D.2070101@free.fr> <20151008174333.GI32532@n2100.arm.linux.org.uk>
 <5616B2F8.3010602@free.fr> <20151008182254.GJ32532@n2100.arm.linux.org.uk>
Message-ID: <5616B7E3.50507@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2015 20:22, Russell King - ARM Linux wrote:
> On Thu, Oct 08, 2015 at 08:16:24PM +0200, Mason wrote:
>> On 08/10/2015 19:43, Russell King - ARM Linux wrote:
>>> On Thu, Oct 08, 2015 at 07:38:53PM +0200, Mason wrote:
>>>> On 08/10/2015 19:16, Mark Rutland wrote:
>>>>> Otherwise this looks ok. If you can respin with the above wording, and
>>>>> s/twd-never-stops/always-on/ in the patch, you can add:
>>>>>
>>>>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>>>>
>>>> Wouldn't you feel like going all-in and Signing-off? ;-)
>>>
>>> Then I'd reject it, because it would be wrong.
>>>
>>> Documentation/SubmittingPatches: [snip]
>>
>> Could someone explain the difference between Acked-by and
>> Reviewed-by?
> 
> Again, I could quote from the above file, but you already have a copy
> of it locally, so you could just read that version instead.  Section 13.

Acked-by: [...] is a record that the acker has at least
reviewed the patch and has indicated acceptance.

Reviewed-by: indicates that the patch has been reviewed and
found acceptable according to the Reviewer's Statement

IIUC Acked-by is stronger than Reviewed-by?

Regards.
