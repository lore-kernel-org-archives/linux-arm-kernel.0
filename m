From: keescook@chromium.org (Kees Cook)
Date: Thu, 20 Oct 2016 11:34:13 -0700
Subject: [PATCH v2 0/3] efi: add support for seeding the kernel RNG from
 UEFI
In-Reply-To: <1476962486-18368-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1476962486-18368-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAGXu5jLo=UX+Rw8kLZdd+iz+aS2JtwpqoxL=-ZMNXAeLE=Ac5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 4:21 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> This implements generic EFI core kernel code to seed the kernel entropy
> pool from a Linux specific UEFI configuration table containing a random seed
> supplied by the firmware. (#1)
>
> In addition, it wires it up for ARM and arm64, by invoking the EFI_RNG_PROTOCOL
> UEFI protocol from the stub, and populating such a UEFI config table using its
> output.

Looks good to me! Now that I understand it. ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Nexus Security
