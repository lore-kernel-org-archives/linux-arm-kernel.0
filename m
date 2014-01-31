From: keescook@chromium.org (Kees Cook)
Date: Fri, 31 Jan 2014 14:50:43 -0800
Subject: [PATCHv3] arm64: Add CONFIG_CC_STACKPROTECTOR
In-Reply-To: <1391115944-10183-1-git-send-email-lauraa@codeaurora.org>
References: <1391115944-10183-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <CAGXu5jKmrpM=oCABXy-UJH6mZ22Z2r-p_R2nZKqGocHJ0vYQ2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 1:05 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
> arm64 currently lacks support for -fstack-protector. Add
> similar functionality to arm to detect stack corruption.
>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Chrome OS Security
