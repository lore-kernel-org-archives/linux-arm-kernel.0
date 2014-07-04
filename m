From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 4 Jul 2014 15:54:19 +0200
Subject: [PATCH 1/2] efi/arm64: fix potential NULL dereference of
 efi.systab
In-Reply-To: <20140704133844.GG16404@arm.com>
References: <1404295802-28030-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140704133844.GG16404@arm.com>
Message-ID: <CAKv+Gu_VJZuzio8oyDA4OKwaeZj3J4WY_kX4s-_zhs1rk35b7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 July 2014 15:38, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Jul 02, 2014 at 11:10:01AM +0100, Ard Biesheuvel wrote:
>> We assign efi.systab using efi_lookup_mapped_addr(), and test for !NULL, but
>> then go on an dereference it anyway.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Thanks. I applied this one (the other patch needs to go in via a
> different route).
>

Eh, actually, I proposed a v2 based on Mark's feedback, but I now see
that I accidentally removed you from the To list.

http://marc.info/?l=linux-arm-kernel&m=140446911506688&w=2

-- 
Ard.
