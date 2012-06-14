From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 13 Jun 2012 22:23:22 -0300
Subject: MXS getting AUART to work with DT.
In-Reply-To: <4FD7EFFC.8010204@grid-net.com>
References: <4FD7EFFC.8010204@grid-net.com>
Message-ID: <CAOMZO5C93a3Cckr_HXm8moW0gafud92qvTXJ=np7MJ3JriR-sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Subodh,

On Tue, Jun 12, 2012 at 10:42 PM, Subodh Nijsure <snijsure@grid-net.com> wrote:
> Hi,
>
> I am testing my mx28 hardware with arm-soc/for-next branch. I have made
> ?additions shown below to my dt file.
>
> What I see is only ttyAPP0 device gets created but not the ttyAPP1, do folks
> who know DT much better than I, see any issues with this DT definition
> below?

I just enabled CONFIG_SERIAL_MXS_AUART and booted my mx28evk (non-DT
case) that registers
auart0 and auart2, but I don't see any ttyAPPx node.

Is there anything I am missing?

I would like to get ttyAPP0/2 working first on non-DT case.

Thanks,

Fabio Estevam
