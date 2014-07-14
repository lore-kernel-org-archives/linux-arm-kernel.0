From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 14 Jul 2014 14:53:27 -0500
Subject: [PATCH v6 2/7] arm64: Introduce VA_BITS and translation level
 options
In-Reply-To: <000101cf6dc6$3b93d510$b2bb7f30$@samsung.com>
References: <000101cf6dc6$3b93d510$b2bb7f30$@samsung.com>
Message-ID: <CAOZdJXWCu-zHuQoAUdiieqsKqCfG9BsZariFqQP=NCgQP-zpNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 4:40 AM, Jungseok Lee <jays.lee@samsung.com> wrote:
> This patch adds virtual address space size and a level of translation
> tables to kernel configuration. It facilicates introduction of
> different MMU options, such as 4KB + 4 levels, 16KB + 4 levels and
> 64KB + 3 levels, easily.

Is there a reason why this patch has not yet been picked up?  It
appears to work just fine, and the change is necessary for ARM SOCs
that support large amounts of memory.  It seems weird that after so
many versions, reviews, and ACKs, that it still not in linux-next.
