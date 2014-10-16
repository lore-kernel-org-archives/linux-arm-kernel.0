From: roy.franz@linaro.org (Roy Franz)
Date: Thu, 16 Oct 2014 10:54:08 -0700
Subject: [PATCH] arm64/efi: set PE/COFF file alignment to 512 bytes
In-Reply-To: <CAKv+Gu_Ky6jUe-Br2E_nThA9ZKYUM2VbuhkRiHwviHh_8hbO-A@mail.gmail.com>
References: <1412960335-22905-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAFECyb8zwUwXAThPVOHNxZGzD6e=WVq4JMZdofNwztnw4YgYwA@mail.gmail.com>
 <20141016135239.GG14343@console-pimps.org>
 <CAKv+Gu_Ky6jUe-Br2E_nThA9ZKYUM2VbuhkRiHwviHh_8hbO-A@mail.gmail.com>
Message-ID: <CAFECyb8o6hmmw3CqKcP093k26XjJtU4Fk-MU1U8O7DMs6HRc3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 9:06 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 16 October 2014 15:52, Matt Fleming <matt@console-pimps.org> wrote:
>> On Fri, 10 Oct, at 10:07:48AM, Roy Franz wrote:
>>> On Fri, Oct 10, 2014 at 9:58 AM, Ard Biesheuvel
>>> <ard.biesheuvel@linaro.org> wrote:
>>> > Change our PE/COFF header to use the minimum file alignment of
>>> > 512 bytes (0x200), as mandated by the PE/COFF spec v8.3
>>> >
>>> > Also update the linker script so that the Image file itself is also a
>>> > round multiple of FileAlignment.
>>> >
>>> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> > ---
>>>
>>> Signed-off-by: Roy Franz <roy.franz@linaro.org>
>>
>> Whut? Is there some patch authorship madness going on here?
>>
>> Who wrote the patch?
>>
>
> I wrote the patch, and I suppose Roy meant to ack it.
>
> Roy?
>
> --
> Ard.
Sorry!
Acked-by: Roy Franz <roy.franz@linaro.org>
