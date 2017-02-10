From: keescook@chromium.org (Kees Cook)
Date: Fri, 10 Feb 2017 10:41:58 -0800
Subject: [PATCH 3/4] arm64: mmu: map .text as read-only from the outset
In-Reply-To: <1486747005-15973-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1486747005-15973-1-git-send-email-ard.biesheuvel@linaro.org>
 <1486747005-15973-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAGXu5jKQjtwZ-JFPBQ8epjuXYbQ4d4s404-=hJm_y=CpsHQFAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 9:16 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Now that alternatives patching code no longer relies on the primary
> mapping of .text being writable, we can remove the code that removes
> the writable permissions post-init time, and map it read-only from
> the outset.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Awesome!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
