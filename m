From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 24 Sep 2011 15:27:18 +0200
Subject: Identifying Primecells
In-Reply-To: <CAKON4Ow1-jTM8fRpm12=5+acCt6A-35ZpWGJ_qMmRHi_JS8wAA@mail.gmail.com>
References: <CAKON4OxqqBh4xFLwiMZzsGrnoG8erQ0hMFX-_VA-EDMvdNkvQQ@mail.gmail.com>
	<4E7C7FA2.30404@gmail.com>
	<CAKON4OzGEo+XvcNg=mzp3jhq3d3m7Z9bvZTSVCNLNjZ=KYbNBQ@mail.gmail.com>
	<4E7C89FC.4090209@gmail.com>
	<CAKON4OxZPFFL5NAgxLPRw2xxnS=v7iVWtQSSLcUJWfOYh4yfjA@mail.gmail.com>
	<1316787049.4611.920.camel@hornet.cambridge.arm.com>
	<CAKON4OxHwjrw-dhH2qvXopqUqmKSx2TCPgW4eVHF9dmQO4=Cvw@mail.gmail.com>
	<1316787754.4611.925.camel@hornet.cambridge.arm.com>
	<CAKON4Ow1-jTM8fRpm12=5+acCt6A-35ZpWGJ_qMmRHi_JS8wAA@mail.gmail.com>
Message-ID: <CAKnu2Mpjv7Ohi4hyPT1Z-8tbjZBBTVZS7F_uCoa9m+kogwXa=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/23 jonsmirl at gmail.com <jonsmirl@gmail.com>:

> So it looks like NXP made almost all of their own peripherals. Which
> means I have to clean up the drivers for all of them.

Totally from-scratch IP blocks exist but is uncommon.

When there are no helpfull primecell IDs giving the secret
of ancestry away readily, fall back to comparing register maps,
this usually reveals the family of hardware and possible
ancestors. (Like was quickly done for the 8250 derivate
serial.)

Yours,
Linus Walleij
