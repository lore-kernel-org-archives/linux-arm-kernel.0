From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Oct 2011 14:03:18 +0200
Subject: [RFC] ARM: at91: gpio add mux check
In-Reply-To: <20111025110936.GO2638@game.jcrosoft.org>
References: <1319462000-32642-1-git-send-email-plagnioj@jcrosoft.com>
	<CACRpkdbDLSy+87Obw2LnuBmrUn_v6WSFjN5PuD_UXSTRq66aWA@mail.gmail.com>
	<20111025110936.GO2638@game.jcrosoft.org>
Message-ID: <CACRpkdZSwtGLr4rD4riF2ZD52ptTQ+06gi5sLOpfdHyiyGvf8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2011 at 1:09 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 10:39 Tue 25 Oct ? ? , Linus Walleij wrote:
>> Is there an AT91 pinmux driver? If yes, I guess it's something custom and I
>> have only looked briefly at these. Generally I would recommend modeling
>> any muxing using the pinctrl subsystem but if and only if Torvalds decide to
>> pull it in.
>
> Yes I start to implement one

Yes! Way to go! I just tried to convince Torvalds to pull this subsystem
in so it's nice to see some traction.

> but I've need to hardcode in the driver the pull, multidrive per function

For the next kernel cycle I (and I guess Steven & the others)
surely want to provide the right interfaces to do also this kind
of stuff. Help us iron it out!

Yours,
Linus Walleij
