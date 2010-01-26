From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 26 Jan 2010 10:53:22 +0000
Subject: [PATCH 2/3] ASoC: AC97: S3C: Add controller driver
In-Reply-To: <1b68c6791001252332l5ee275c9we39c98691ad7692c@mail.gmail.com>
References: <1264485101-13782-1-git-send-email-jassisinghbrar@gmail.com>
	<1264485101-13782-2-git-send-email-jassisinghbrar@gmail.com>
	<1b68c6791001252332l5ee275c9we39c98691ad7692c@mail.gmail.com>
Message-ID: <20100126105322.GG15759@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 04:32:45PM +0900, jassi brar wrote:
> On Tue, Jan 26, 2010 at 2:51 PM,  <jassisinghbrar@gmail.com> wrote:

Please delete irrelevant context when replying to mails, it's much
easier to find the actual new text in the message that way.

> > + ? ? ? ? ? ? ? ? ? ? ? /* NOTE: If the codec ouputs just one slot,
> > + ? ? ? ? ? ? ? ? ? ? ? ?* it *seems* our AC97 controller reads the only
> > + ? ? ? ? ? ? ? ? ? ? ? ?* valid slot(if either 3 or 4) for PCM-In.
> > + ? ? ? ? ? ? ? ? ? ? ? ?* For such cases, we record Mono.
> > + ? ? ? ? ? ? ? ? ? ? ? ?*/
> > + ? ? ? ? ? ? ? ? ? ? ? .channels_min = 1,

>   I would like to remove this anomaly and set channels_min = 2

Why?

>  And remove the second DAI_LINK in machine driver.

Again, why?
