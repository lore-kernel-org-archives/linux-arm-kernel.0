From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 27 Feb 2014 09:35:40 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140226200537.GC16149@cbox>
References: <20140226183454.GA14639@cbox> <5553754.0b4gMg5OS7@wuerfel>
 <20140226200537.GC16149@cbox>
Message-ID: <CAHkRjk57LyJGPZ4UdLVFpLrE2VeaY4doCwKo8UjbpzK52jTbVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2014 20:05, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Wed, Feb 26, 2014 at 08:55:58PM +0100, Arnd Bergmann wrote:
>> On Wednesday 26 February 2014 10:34:54 Christoffer Dall wrote:
>> > For more information about UEFI and ACPI booting, see [4] and [5].
>>
>> What's the point of having ACPI in a virtual machine? You wouldn't
>> need to abstract any of the hardware in AML since you already know
>> what the virtual hardware is, so I can't see how this would help
>> anyone.
>
> The most common response I've been getting so far is that people
> generally want their VMs to look close to the real thing, but not sure
> how valid an argument that is.
>
> Some people feel strongly about this and seem to think that ARMv8
> kernels will only work with ACPI in the future...

My strong feeling is that AArch64 kernels *may* support ACPI in the future ;).

On a more serious note, both FDT and ACPI will be first-class citizens
on AArch64 and I have no intention whatsoever of dropping FDT.

-- 
Catalin
