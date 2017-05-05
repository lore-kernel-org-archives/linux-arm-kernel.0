From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 5 May 2017 12:38:32 -0700
Subject: [GIT PULL] arm64 updates for 4.12
In-Reply-To: <20170505161345.GA23336@e104818-lin.cambridge.arm.com>
References: <20170505161345.GA23336@e104818-lin.cambridge.arm.com>
Message-ID: <CA+55aFxFoV_BUbQ=fUAWd2WxGRPe3K_eb7yfZYrh7oa6UOgOCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 5, 2017 at 9:13 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> diff --cc arch/arm64/include/asm/bug.h

Hmm. The trivial resolution I did gets a different diff as the end
result, but your diff looks different.

I think you used "-U2" to make for a smaller and more targeted context..

So I think the trivial resolution is what you meant. But I couldn't
test it, so I thought I'd mention this oddity.

               Linus
