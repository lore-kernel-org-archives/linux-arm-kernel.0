From: radioconfusion@gmail.com (radioconfusion at gmail.com)
Date: Mon, 07 Nov 2016 10:53:36 +0200
Subject: [crypto] [marvell-cesa] Possible regression after Linux 4.7
Message-ID: <58204111.4d881c0a.d56ba.a0fa@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Thu, 3 Nov 2016 14:57:06 +0100, Romain Perier wrote:
>
> > Do you have any improvement for the issue?
> > Please let me know if you need any help to resolve it.
> >
> > Best Regards,
> > Jussi
> >
>
> Sorry for the delay.
> Could you try to revert locally commit
> 2786cee8e50bb4b4303dc22665f391b72318fa84 (crypto: marvell - Move SRAM
> I/O operations to step functions) ?
>
> It seems to fix most of the issues I had with curl.
> I will continue to investigate, that's just to confirm if it fixes the
> issues for you.
>

Thanks for this suggestion.
Unfortunately, I didn't get improvements using curl with this revertion.

Thanks for your investigation. Waiting for your input.

Best Regards,
Jussi
