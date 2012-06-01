From: javier.martin@vista-silicon.com (javier Martin)
Date: Fri, 1 Jun 2012 09:02:52 +0200
Subject: [ehci-mxc] USB stopped working in i.MX27 based Visstrim_M10 board.
In-Reply-To: <CAOMZO5A+f0oMx8RUBtf0cYcN3sRnXBpBBW_=n4k-4XYpXu2HLw@mail.gmail.com>
References: <CACKLOr2h+a6NYRQn4gJ5A5dQ_b2hRbM+NYpt22Yh674+rBUvKQ@mail.gmail.com>
 <CAOMZO5A+f0oMx8RUBtf0cYcN3sRnXBpBBW_=n4k-4XYpXu2HLw@mail.gmail.com>
Message-ID: <CACKLOr1tazoD+zMEecFW=KGnY4bmi5-0wbiujU5S+V0=by8hfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 May 2012 20:08, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Javier,
>
> On Thu, May 24, 2012 at 8:00 AM, javier Martin
> <javier.martin@vista-silicon.com> wrote:
>> Hi,
>> in kernel 3.4 USB doesn't work anymore in Visstrim_M10 board. It is
>> based on an i.MX27 chip and this is the log I get when connecting an
>> UVC webcam:
>
> Was this problem fixed by your "[PATCH] Visstrim M10: fix gpio handling" patch ?

Yes it was.
I am going to send a new version tough, as requested by Sascha.

Regards.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
