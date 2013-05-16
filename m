From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 May 2013 14:29:01 +0100
Subject: [PATCH v2 02/10] arm64: uaccess s/might_sleep/might_fault/
In-Reply-To: <90a2283bb84b6ce77c9966d76dbceb5c7edffd18.1368702323.git.mst@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
 <90a2283bb84b6ce77c9966d76dbceb5c7edffd18.1368702323.git.mst@redhat.com>
Message-ID: <CAHkRjk5bHV3WDSnfQLr1MPTXGXXKP+XKRbqL2fn_bPmXt_7=cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 May 2013 12:10, Michael S. Tsirkin <mst@redhat.com> wrote:
> The only reason uaccess routines might sleep
> is if they fault. Make this explicit.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/arm64/include/asm/uaccess.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
