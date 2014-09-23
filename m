From: jesper.nilsson@axis.com (Jesper Nilsson)
Date: Tue, 23 Sep 2014 17:40:16 +0200
Subject: [PATCH] atomic_read: Use ACCESS_ONCE() instead of cast to volatile
In-Reply-To: <1411482607-20948-1-git-send-email-bobby.prani@gmail.com>
References: <1411482607-20948-1-git-send-email-bobby.prani@gmail.com>
Message-ID: <20140923154016.GT18910@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 04:29:50PM +0200, Pranith Kumar wrote:
> Use the much reader friendly ACCESS_ONCE() instead of the cast to volatile. This
> is purely a style change.
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  arch/alpha/include/asm/atomic.h    | 4 ++--
>  arch/arm/include/asm/atomic.h      | 2 +-
>  arch/arm64/include/asm/atomic.h    | 4 ++--
>  arch/avr32/include/asm/atomic.h    | 2 +-
>  arch/cris/include/asm/atomic.h     | 2 +-

For the CRIS parts:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson at axis.com
