From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Thu, 27 Mar 2014 14:27:37 +0100
Subject: [PATCH] ARM: imx6/dt: add ccm dependency upon ckil, ckih1 and
 osc clocks
In-Reply-To: <CAOMZO5D+rinC8zDMGTS9ACA1nBQvy8X3PqXc7iyWToS54amesw@mail.gmail.com>
References: <5333DA13.2080505@gmail.com>	<1395907913-23808-1-git-send-email-b.brezillon.dev@gmail.com>
 <CAOMZO5D+rinC8zDMGTS9ACA1nBQvy8X3PqXc7iyWToS54amesw@mail.gmail.com>
Message-ID: <53342749.6060403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/03/2014 12:19, Fabio Estevam a ?crit :
> On Thu, Mar 27, 2014 at 5:11 AM, Boris BREZILLON
> <brezillonboris@gmail.com> wrote:
>> Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
> Please provide a commit message, thanks.

This was sent as a test to verify my assumptions.

But if you want a commit message, how about this one ?

Define ccm clocks dependencies upon ckil, ckih1 and osc fixed clocks
to enforce probing order.

Anyway this patch is buggy (see my previous answer) and I'm not sure
I'm one that should submit it :-).

Best Regards,

Boris
