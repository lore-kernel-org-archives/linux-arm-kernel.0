From: labbott@redhat.com (Laura Abbott)
Date: Tue, 25 Oct 2016 17:46:39 -0700
Subject: [PATCH 00/10] arm64: move thread_info off of the task stack
In-Reply-To: <20161024180941.GT15620@leverpostej>
References: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
 <10401f46-cabc-23ec-a448-c377dbce7911@redhat.com>
 <20161024174840.GR15620@leverpostej>
 <fb8c8a44-36c8-9bbb-5cbb-9b42fd815d8d@redhat.com>
 <20161024180941.GT15620@leverpostej>
Message-ID: <2db24d48-3a8a-11c2-9b2c-26a51a3baa36@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2016 11:09 AM, Mark Rutland wrote:
> On Mon, Oct 24, 2016 at 10:58:10AM -0700, Laura Abbott wrote:
>> On 10/24/2016 10:48 AM, Mark Rutland wrote:
>>> On Mon, Oct 24, 2016 at 10:38:59AM -0700, Laura Abbott wrote:
>>>> On 10/19/2016 12:10 PM, Mark Rutland wrote:
>>>>> [3] https://git.kernel.org/cgit/linux/kernel/git/mark/linux.git/log/?h=arm64/ti-stack-split
>>>
>>>> I pulled the arm64/ti-stack-split branch on top of a Fedora
>>>> tree and ran back-to-back kernel RPM builds for a long weekend.
>>>> It's still going as of this morning so you can take that as a
>>>>
>>>> Tested-by: Laura Abbott <labbott@redhat.com>
>>>
>>> Thanks! That's much appreciated!
>>>
>>> Just to check, did you grab the version with entry.S fixes rolled in
>>> (where the head is 657f54256c427fec)?
>>
>> Ah I did not. That came in after I started the test. I'll start
>> another run with the new version.
>
> Sorry about that; thanks for respinning!
>
> It's really crazy how broken a kernel can be yet still "work"; clearly
> we better tests are needed. :/
>
> Thanks,
> Mark.
>

While not as long running, I gave it another spin and it seemed to
work fine as well.

Thanks,
Laura
