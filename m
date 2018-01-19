From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 19 Jan 2018 09:59:07 -0200
Subject: [PATCH] ARM: dts: imx6qdl-udoo: Disable usbh1 to avoid kernel hang
In-Reply-To: <84391569-cdb9-1c17-7e37-6fdad954d549@maciej.szmigiero.name>
References: <1516278858-15464-1-git-send-email-fabio.estevam@nxp.com>
 <84391569-cdb9-1c17-7e37-6fdad954d549@maciej.szmigiero.name>
Message-ID: <CAOMZO5DQ9T_003gzq-0Q-HrUEhzoZOHd-647DkUCQP9ka9ti4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maciej,

On Thu, Jan 18, 2018 at 9:11 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:

> Hmm, did you get reports or checked that it actually hangs?

Both :-)

>
> As far as I remember last time I ran a kernel without Peter's power
> sequence library on this board it only wasn't able to communicate with
> the on-board USB hub (and devices behind it), but besides this was
> able to boot successfully.
> But my memory may be wrong since it was some time ago.

Currently we are not able to reach the prompt without this patch as
the system hangs.
