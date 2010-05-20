From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 20 May 2010 17:28:53 +0900
Subject: [RFC PATCH v2] preliminary support for sparse IRQ
In-Reply-To: <AANLkTikSXcn9nnvaVHAsoDPmLN30E_TjNVdXu1vCOH74@mail.gmail.com>
References: <AANLkTikSXcn9nnvaVHAsoDPmLN30E_TjNVdXu1vCOH74@mail.gmail.com>
Message-ID: <20100520082853.GA18885@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 06:34:49PM +0800, Eric Miao wrote:
> commit 2e2e087d96630c95dbce57036680cf917e906cf1
> Author: Eric Miao <eric.y.miao@gmail.com>
> Date:   Mon Dec 28 12:59:59 2009 +0800
> 
>     [ARM] preliminary support for sparse IRQ
> 
>     So to allow NR_IRQS to be dynamic and platforms to specify the number
>     of IRQs really needed.
> 
>     Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> 
It would be nice to see this applied, we plan to use sparseirq
unconditionally for shmobile (as sh already does).
