From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 20 May 2010 17:37:52 +0900
Subject: [RFC PATCH v2] preliminary support for sparse IRQ
In-Reply-To: <AANLkTikVR8z_FqB4RvRWUIv2yNWw_p6gB9JQAeAMFQjq@mail.gmail.com>
References: <AANLkTikSXcn9nnvaVHAsoDPmLN30E_TjNVdXu1vCOH74@mail.gmail.com>
	<20100520082853.GA18885@linux-sh.org>
	<AANLkTikVR8z_FqB4RvRWUIv2yNWw_p6gB9JQAeAMFQjq@mail.gmail.com>
Message-ID: <20100520083752.GB18885@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 20, 2010 at 04:37:16PM +0800, Eric Miao wrote:
> On Thu, May 20, 2010 at 4:28 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Tue, May 18, 2010 at 06:34:49PM +0800, Eric Miao wrote:
> >> commit 2e2e087d96630c95dbce57036680cf917e906cf1
> >> Author: Eric Miao <eric.y.miao@gmail.com>
> >> Date: ?? Mon Dec 28 12:59:59 2009 +0800
> >>
> >> ?? ?? [ARM] preliminary support for sparse IRQ
> >>
> >> ?? ?? So to allow NR_IRQS to be dynamic and platforms to specify the number
> >> ?? ?? of IRQs really needed.
> >>
> >> ?? ?? Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> >>
> > It would be nice to see this applied, we plan to use sparseirq
> > unconditionally for shmobile (as sh already does).
> >
> 
> Thanks Paul. Sounds like an Acked-by.

Indeed.

Acked-by: Paul Mundt <lethal@linux-sh.org>
