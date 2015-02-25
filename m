From: bobby.prani@gmail.com (Pranith Kumar)
Date: Wed, 25 Feb 2015 12:32:08 -0500
Subject: [RFC PATCH] arm: asm/cmpxchg.h: Add support half-word xchg()
In-Reply-To: <20150225170250.GD8656@n2100.arm.linux.org.uk>
References: <1424878581-11701-1-git-send-email-bobby.prani@gmail.com>
 <3465519.0ga9zC7F7b@wuerfel> <20150225170250.GD8656@n2100.arm.linux.org.uk>
Message-ID: <CAJhHMCCUi0_HfDh56512QpkjK1u-DAeiQRhLkb2cYZdU0L0wRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 12:02 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> Unfortunately, the BUG message seems incomplete, can you reproduce this
>> with CONFIG_DEBUG_BUGVERBOSE enabled?
>
> That isn't because CONFIG_DEBUG_BUGVERBOSE isn't set.  It's because
> the message author decided that the remainder of the kernel bug message
> wasn't useful to report.  After all, it's just a load of hex numbers
> and symbolic information.  Who would want that junk.
>
> (Some people really don't get this: we print stuff from the kernel
> because it gives _us_ useful information to debug problems like this,
> but because they don't understand it themselves, they decide they can
> omit it from their bug reports...)
>

I apologize for not pasting the entire back trace. It was in a test
module I wrote testing synchronization primitives and did not think
the back trace would be useful to report.

I will include verbose details from now on.

Thanks!
-- 
Pranith
