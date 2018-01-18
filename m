From: mail@maciej.szmigiero.name (Maciej S. Szmigiero)
Date: Fri, 19 Jan 2018 00:56:15 +0100
Subject: [PATCH] ARM: dts: imx6qdl-udoo: Disable usbh1 to avoid kernel hang
In-Reply-To: <CAOcK=CP=m0oBfvPuMEXLGG_5rxqchh5dg9SLbbiAUEvEyj=aMg@mail.gmail.com>
References: <1516278858-15464-1-git-send-email-fabio.estevam@nxp.com>
 <84391569-cdb9-1c17-7e37-6fdad954d549@maciej.szmigiero.name>
 <CAOcK=CNuopm0bq3s-jb2MJ0hHhLyYC1h3zquO__syN2=tU_nKQ@mail.gmail.com>
 <513e5b07-0209-0d30-f8e2-5ff1799d8a2d@maciej.szmigiero.name>
 <CAOcK=CP=m0oBfvPuMEXLGG_5rxqchh5dg9SLbbiAUEvEyj=aMg@mail.gmail.com>
Message-ID: <301f56e0-00e5-ccb2-0d40-69fb53041800@maciej.szmigiero.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.01.2018 00:50, Markus Rathgeb wrote:
>> Does applying Fabio's patch to the freezing 4.13 or 4.15-rc kernel cause it to boot
> successfully?
> 
> 
> AFAIK The latest series that Peter Chen to address the issue was posted was
> v16 from June, 2017.
> I didn't try it yet myself.
> Will give it a try the next days.

Peter's power sequence library patches do work, I'm using them on
4.15-rc without problems.

However, in my previous question I inquired whether the Fabio's "Disable usbh1 to
avoid kernel hang" patch, that this email thread is about, when applied to the
freezing 4.13 or 4.15-rc kernel, cause it to boot successfully - does it?

Maciej
