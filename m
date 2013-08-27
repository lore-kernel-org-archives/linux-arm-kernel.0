From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 27 Aug 2013 15:53:29 +0200
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
In-Reply-To: <521CA888.1080909@baylibre.com>
References: <20130827181353.319c150858829df1bb68d60b@canb.auug.org.au>
 <521C6961.9020103@linutronix.de>
 <CABxcv=mg6t5wPqpF3j5sr_76qfZ7N7KgpWhcKSGoPTOcaR=V6A@mail.gmail.com>
 <521CA888.1080909@baylibre.com>
Message-ID: <521CAF59.1090203@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2013 03:24 PM, Benoit Cousson wrote:
> Hi Sebatian,

Hi Benoit,

> Yes. DT patches are an endless source of merge conflicts if they are
> merge throught different trees.

Usually there are small conflicts because two people added / changed a
node nearby. This patch turned the .dts file almost upside down.

> What was discussed with Olof and Arnd during Connect is that we should
> avoid merging DT patches outside arm-soc tree to avoid that kind of
> situation.

I am aware of this now. However these changes belonged together because
a) they belonged together and b) would break the driver until the .dts
changes and driver code is in-sync.
In future I am going to ask you for a topic branch so I can get my
changes in one piece without breaking stuff in the middle.

What do we do now?

> Regards,
> Benoit

Sebastian
