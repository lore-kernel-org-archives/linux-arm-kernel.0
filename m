From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 11 Jun 2013 18:37:24 +0900
Subject: [PATCH 1/2] ARM: shmobile: irqpin: add a DT property to enable
 masking on parent
In-Reply-To: <Pine.LNX.4.64.1305241109530.1090@axis700.grange>
References: <Pine.LNX.4.64.1305241109530.1090@axis700.grange>
Message-ID: <CANqRtoTqHiRixV571CrMkc=ijWcrfZFzaSrfjN1SKRNTgTTcZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 6:13 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> To disable spurious interrupts, that get triggered on certain hardware, the
> irqpin driver masks them on the parent interrupt controller. To specify
> such broken devices a .control_parent parameter can be provided in the
> platform data. In the DT case we need a property, to do the same.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> These two patches simply split the earlier "ARM: shmobile: irqpin: fix
> handling of spurious interrupts in DT case" patch into two parts.
> Otherwise no change.

I'm fine with this portion of the patch series. Thanks for your help!

Acked-by: Magnus Damm <damm@opensource.se>
