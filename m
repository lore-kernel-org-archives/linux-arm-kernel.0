From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Wed, 07 Nov 2012 16:18:38 +0900
Subject: [PATCH 00/10] serial: sh-sci fixes - console PM, SCIFB,
 SMP lockup, etc.
In-Reply-To: <509A0658.1010503@renesas.com>
References: <509A0658.1010503@renesas.com>
Message-ID: <509A0B4E.1030801@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/7/2012 3:57 PM, Shinya Kuribayashi wrote:
> Hi Paul and serial forks,
[...]
> Takashi YOSHII (4):
>       serial: sh-sci: fix condition test to set SCBRR
>       serial: sh-sci: support lower baud rate
>       serial: sh-sci: mask SCTFDR/RFDR according to fifosize
>       serial: sh-sci: fix common SCIFB regmap definition
> 
> Teppei Kamijou (1):
>       serial: sh-sci: console runtime PM support (revisit)
> 
>  drivers/tty/serial/sh-sci.c | 140 ++++++++++++++++++--------------------------
>  1 file changed, 56 insertions(+), 84 deletions(-)

Oops, I forgot to append proper From: author lines in five commits
(patch 04/10 to 09/10).  Didn't mean to supersede your authoship.

I'd respin the patchset later, waiting for some feedback.
--
Shinya Kuribayashi
Renesas Electronics
