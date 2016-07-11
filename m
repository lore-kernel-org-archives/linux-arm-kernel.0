From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 11 Jul 2016 17:50:16 +0200
Subject: [PATCH v8 4/4] serial: pl011: add console matching function
In-Reply-To: <5783AFDE.1090408@gmail.com>
References: <1463749405-11640-1-git-send-email-aleksey.makarov@linaro.org>
 <1463749405-11640-5-git-send-email-aleksey.makarov@linaro.org>
 <20160622121813.GA20023@yury-N73SV>
 <7CC4D455-323E-4B33-A931-2104E2DDDC0D@hurleysoftware.com>
 <20160622204548.GB28766@yury-N73SV> <5783AFDE.1090408@gmail.com>
Message-ID: <5783C038.5070504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/07/16 16:40, Matthias Brugger wrote:

>
> I tried to apply these patches against linux-next. They needed some
> changes to apply, which is quite normal after such a long time. Apart
> from that the DBG2 subtype patch didn't end up in mainline, so this
> patches do not compile.
>
> I followed up on that on the corresponding thread. Please don't forget
> to pin-point in the introduction mail to any other series which is
> needed for your patches to compile/work.
>

Ok, I sorted out, that the DBG2 subtypes actually are part of mainline 
and that I screwed up my branches.

Sorry for the noise.
Matthias
