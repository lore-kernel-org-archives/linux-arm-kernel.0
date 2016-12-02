From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 2 Dec 2016 12:50:28 -0300
Subject: [PATCH] imx_v6_v7_defconfig: enable SPIDEV module
In-Reply-To: <CABxcv=nSUfDT-bqHBm2e0XY55Qp4nH+66PriMqnix2RTsN0BNQ@mail.gmail.com>
References: <20161202145631.19292-1-gary.bisson@boundarydevices.com>
 <CAOMZO5C8OH6obRn_8zh5HA9zoanRXUpoqk=vEBx+fW3wraNS6Q@mail.gmail.com>
 <20161202152718.o4xv2ru5r7xw7t5e@t450s.lan>
 <CABxcv=nSUfDT-bqHBm2e0XY55Qp4nH+66PriMqnix2RTsN0BNQ@mail.gmail.com>
Message-ID: <CABxcv=myE8V2+=ZT6CJR_ZVVDy7aOLL6D10PADAqDz5XMjeoww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Gary,

On Fri, Dec 2, 2016 at 12:44 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:

[snip]

>
> This seems to have been added just because people weren't looking that
> closer to DT patches at the beginning, but now is forbidden. That's
> why the kernel now warns about it.
>
>>> Then they will trigger the following warning below (from the spidev
>>> probe function):
>>>

I guess I didn't make clear on my previous email, but I'm not against
$SUBJECT. I think that the platforms that currently have nodes using
"spidev" as compatible need to be cleaned up, and so I find it
valuable to have this option enabled so people are aware of the issue.

Best regards,
Javier
