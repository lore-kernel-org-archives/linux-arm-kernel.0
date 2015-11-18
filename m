From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 18 Nov 2015 10:14:58 -0200
Subject: [PATCH 2/2] ARM: dts: imx6q: add Novena board
In-Reply-To: <1447845958.3144.61.camel@pengutronix.de>
References: <1447840120-8513-1-git-send-email-marex@denx.de>
 <1447840120-8513-2-git-send-email-marex@denx.de>
 <1447841412.3144.57.camel@pengutronix.de>
 <201511181135.40171.marex@denx.de>
 <1447845958.3144.61.camel@pengutronix.de>
Message-ID: <CAOMZO5Cdz8qi4rATd1K8vGhbuJzDD0Mt38Q9LwnrT7zbqCtxUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 9:25 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

>> This is surprising to me, since all the boards I checked use this /regulators
>> simple bus to contain all the regulators. Is this going to change now ?
>
> Yes, there are a lot of bad examples out there, mainly because people
> wanted to logically group the regulators together. But as it isn't
> representing any real hardware we should really try to move away from
> this practice.

Agreed.

I have tried to fixing this usage on sabresd board:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/231934.html

,and there was some discussions whether this was churn or not, so I
ended up not resending it.

IMHO we should make this consistent in the various dts files.

Regards,

Fabio Estevam
