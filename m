From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 27 Jan 2017 18:03:09 +0000
Subject: [PATCH 0/8] efi: Pass secure boot mode to kernel [ver #6]
In-Reply-To: <CAKv+Gu9+i=QvNYN9SbphzG2Ye6aY=9DvAd+TnWN_Bn76LS8kMQ@mail.gmail.com>
References: <148120020832.5854.5448601415491330495.stgit@warthog.procyon.org.uk>
 <20170111150150.GC29649@codeblueprint.co.uk>
 <CAKv+Gu-PR9KoEe+RwgohC-BSyE+5CPR98HjnohSiGL8yw17-HA@mail.gmail.com>
 <CAKv+Gu9+i=QvNYN9SbphzG2Ye6aY=9DvAd+TnWN_Bn76LS8kMQ@mail.gmail.com>
Message-ID: <CAKv+Gu8TuQxPGh5F2VPvpwUJ2=cJw9H+1C4BFJkYwJX9M1P-Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 January 2017 at 17:15, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 11 January 2017 at 15:05, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> On 11 January 2017 at 15:01, Matt Fleming <matt@codeblueprint.co.uk> wrote:
>>> On Thu, 08 Dec, at 12:30:08PM, David Howells wrote:
>>>>
>>>> Here's a set of patches that can determine the secure boot state of the
>>>> UEFI BIOS and pass that along to the main kernel image.  This involves
>>>> generalising ARM's efi_get_secureboot() function and making it mixed-mode
>>>> safe.
>>>
>>> This version looks OK to me apart from the couple of comments I made.
>>>
>>> Ard, did you take a look? In particular some boot testing on ARM/arm64
>>> would be useful. x86 boots fine in both regular and mixed mode but
>>> I've only tested without Secure Boot enabled.
>>
>> I did take a look at these patches (and commented on them) as they
>> were coming in, but I haven't yet gone through them as thoroughly as I
>> should. I will test them on ARM/arm64 as well.
>
> Apologies for the tardiness. I intend to look into these tomorrow.

These patches build and run fine on arm, including on secure boot
systems, so I don't have any objections.

Once the open discussion points re x86 are resolved, I can proceed and
merge them if desired. Matt?
