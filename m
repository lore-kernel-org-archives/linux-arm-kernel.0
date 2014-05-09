From: agnel.joel@gmail.com (Joel Fernandes)
Date: Thu, 8 May 2014 23:22:50 -0500
Subject: [PATCH 3/5] irqchip: crossbar: Skip some irqs from getting mapped
 to crossbar
In-Reply-To: <536C2071.8040502@ti.com>
References: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>
 <1399299527-10955-4-git-send-email-r.sricharan@ti.com>
 <536BD9D8.4080905@ti.com> <20140508203659.GA5620@kahuna>
 <CAD=GYpbQQxQgKd3oZcAuWrxoD4VrkKzpybd11qwxs405HSUVGw@mail.gmail.com>
 <536C0DC4.7090309@ti.com>
 <CAD=GYpav4mHaqo4jfb0ePchf3cvuvSnFKj_+osbrt_8-tYRRrQ@mail.gmail.com>
 <536C2071.8040502@ti.com>
Message-ID: <CAD=GYpbRn=LEthpAUX9LNBGTB4iDs7TGiSSgLJuuS0tSatRRJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 8, 2014 at 7:25 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
[..]
> The concern was really not where the code resides but what the actual
> hardware is and how can it fit into Linux. The whole reason I was
> actually against irqhcip from beginning of crossbar series was the
> hardware is not irqchip rather just a router. Thomas the formally
> NAKed that approach on thread [1]. If there are bugs, doesn't mean
> we can make fit the hardware into some subsystem where it can't be
> described.
>
> Regards,
> Santosh
> [1] https://lkml.org/lkml/2013/9/13/413
>

Ok, thanks for pointing to the post.
