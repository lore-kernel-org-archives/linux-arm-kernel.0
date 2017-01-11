From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 11 Jan 2017 15:05:14 +0000
Subject: [PATCH 0/8] efi: Pass secure boot mode to kernel [ver #6]
In-Reply-To: <20170111150150.GC29649@codeblueprint.co.uk>
References: <148120020832.5854.5448601415491330495.stgit@warthog.procyon.org.uk>
 <20170111150150.GC29649@codeblueprint.co.uk>
Message-ID: <CAKv+Gu-PR9KoEe+RwgohC-BSyE+5CPR98HjnohSiGL8yw17-HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 January 2017 at 15:01, Matt Fleming <matt@codeblueprint.co.uk> wrote:
> On Thu, 08 Dec, at 12:30:08PM, David Howells wrote:
>>
>> Here's a set of patches that can determine the secure boot state of the
>> UEFI BIOS and pass that along to the main kernel image.  This involves
>> generalising ARM's efi_get_secureboot() function and making it mixed-mode
>> safe.
>
> This version looks OK to me apart from the couple of comments I made.
>
> Ard, did you take a look? In particular some boot testing on ARM/arm64
> would be useful. x86 boots fine in both regular and mixed mode but
> I've only tested without Secure Boot enabled.

I did take a look at these patches (and commented on them) as they
were coming in, but I haven't yet gone through them as thoroughly as I
should. I will test them on ARM/arm64 as well.
