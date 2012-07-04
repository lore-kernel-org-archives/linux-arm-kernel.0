From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 4 Jul 2012 08:41:08 -0300
Subject: Clock problems in i.MX27 Visstrim M10 (linux-3.5-rc5).
In-Reply-To: <CACKLOr1OYmoWXCU=Q_0O1H5jYcAGXO11ji6d_j7SjyaLZuygAA@mail.gmail.com>
References: <CACKLOr0z13sMQhb14YpDp7UtwfhVoqRAMOJCA+geapq=Lh7VuQ@mail.gmail.com>
 <CAOMZO5CeGKJ6kERaCkNE0Cpy2X78CUN_-au5Q+cCtLLjtNXMDg@mail.gmail.com>
 <CACKLOr1oeci84Fs7HTRD2Myie8zjKExA15mxM3z7dkq8QfvDmg@mail.gmail.com>
 <CAOMZO5Bdpe43wSAS-D34LzVA9gAKwGTjsw_1f3iPizVsWJW7kw@mail.gmail.com>
 <CACKLOr1OYmoWXCU=Q_0O1H5jYcAGXO11ji6d_j7SjyaLZuygAA@mail.gmail.com>
Message-ID: <CAOMZO5CLV6TuQUTzYUSvoi6apNUtSLhkbh8Jj3onAnc99TWxWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 4, 2012 at 8:30 AM, javier Martin
<javier.martin@vista-silicon.com> wrote:

> mx2_emmaprp.c is a different driver for the same device. Its a mem2mem
> driver that gets frames from memory in one video format and then
> outputs frames in another video format. It hasn't got anything to do
> with the mx2_camera.c apart from the fact they can't be used at the
> same time since they share emma resources.

Ok, understood.

So the original mx2_camera patch i sent you plus the clk-imx27.c
changes (calling clk_register_clkdev again with the
second name) fixes the issue for you?

If so, then maybe I can send the original mx2_camera patch to the
linux-media list.

Please confirm.

I will be able to test it later today.

Regards,

Fabio Estevam
