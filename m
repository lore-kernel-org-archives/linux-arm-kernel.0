From: javier.martin@vista-silicon.com (javier Martin)
Date: Mon, 9 Jul 2012 09:00:57 +0200
Subject: Clock problems in i.MX27 Visstrim M10 (linux-3.5-rc5).
In-Reply-To: <CAOMZO5ASmzk1wYauAfM0JwixnViyudmn+AtqyagJg2J4a56Paw@mail.gmail.com>
References: <CACKLOr0z13sMQhb14YpDp7UtwfhVoqRAMOJCA+geapq=Lh7VuQ@mail.gmail.com>
 <CAOMZO5CeGKJ6kERaCkNE0Cpy2X78CUN_-au5Q+cCtLLjtNXMDg@mail.gmail.com>
 <CACKLOr1oeci84Fs7HTRD2Myie8zjKExA15mxM3z7dkq8QfvDmg@mail.gmail.com>
 <CAOMZO5Bdpe43wSAS-D34LzVA9gAKwGTjsw_1f3iPizVsWJW7kw@mail.gmail.com>
 <CACKLOr1OYmoWXCU=Q_0O1H5jYcAGXO11ji6d_j7SjyaLZuygAA@mail.gmail.com>
 <CAOMZO5CLV6TuQUTzYUSvoi6apNUtSLhkbh8Jj3onAnc99TWxWg@mail.gmail.com>
 <CAOMZO5A0YXcZOB+ov+dD0MVJr0XSr=Ufg5snGDLvZ9=GyK=xMw@mail.gmail.com>
 <CAOMZO5BwraSVyW8SZjoN19gy-eZ2tXXPRT879PdAOu38Yf-z0g@mail.gmail.com>
 <CACKLOr1EoOL1SQ_QW7P3YtMYgVwt9uE-x728-YrZB8rEh45OMw@mail.gmail.com>
 <CAOMZO5ASmzk1wYauAfM0JwixnViyudmn+AtqyagJg2J4a56Paw@mail.gmail.com>
Message-ID: <CACKLOr3Bd3acC2aRz=1RO=hy2VLnx6fjMaXh45yaqh6z0EM6hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 July 2012 14:32, Fabio Estevam <festevam@gmail.com> wrote:
> On Fri, Jul 6, 2012 at 3:44 AM, javier Martin
> <javier.martin@vista-silicon.com> wrote:
>> The attached patch solves mx2_camera clock problems.
>>
>> It can be also found by the following subject in the lists:
>>
>> media: i.MX27: Fix emma-prp clocks in mx2_camera.c
>
> Just tried your patch against today's linux-next and I still get the
> following on a mx27pdk:
>
> soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
> mx2-camera mx2-camera.0: Camera driver attached to camera 0
> ov2640 0-0030: Product ID error fb:fb
> mx2-camera mx2-camera.0: Camera driver detached from camera 0
> mx2-camera mx2-camera.0: MX2 Camera (CSI) driver probed, clock frequency: 665000
>
> Are you able to probe i2c correctly on your board?

Yes, I am and my patch does not touch any of the I2C settings or clocks.


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
