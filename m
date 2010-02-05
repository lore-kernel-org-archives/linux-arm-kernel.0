From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 5 Feb 2010 08:30:50 +0000
Subject: [RFC PATCH 3/3] [ARM] Allow boards to specify the exact number
	of IRQs needed
In-Reply-To: <f17812d71002041112x6f8308b5q6bc37f6608a3efc9@mail.gmail.com>
References: <f17812d71002041112x6f8308b5q6bc37f6608a3efc9@mail.gmail.com>
Message-ID: <20100205083050.GG13267@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2010 at 11:12:37AM -0800, Eric Miao wrote:
> commit 988a6a2bd322d83eba42c05cb6cb77a74cba056b
> Author: Eric Miao <eric.y.miao@gmail.com>
> Date:   Thu Feb 4 11:06:35 2010 -0800
> 
>     [ARM] Allow boards to specify the exact number of IRQs needed
> 
>     This will only take effect if SPARSE_IRQ is enabled, any board that
>     depends on this _only_ has to explicitly select SPARSE_IRQ.
> 
>     Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

out of interest, what happens if the user wants to instantiate an irq
that is above the board's nr_irq setting?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
