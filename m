From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Aug 2011 14:28:12 +0200
Subject: [PATCH 0/4 v4] pin controller subsystem v4
In-Reply-To: <CAGsJ_4z7s-ibmUuR1DA6Jps030dRrnE8M0dUWHoMhMPFtyyY_A@mail.gmail.com>
References: <1313747619-32222-1-git-send-email-linus.walleij@stericsson.com>
	<CAGsJ_4z7s-ibmUuR1DA6Jps030dRrnE8M0dUWHoMhMPFtyyY_A@mail.gmail.com>
Message-ID: <CACRpkdb4-0TfO-viUoZyW3VoLnVuo2ztHTX=8Hef3_RYWB52vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2011 at 4:42 PM, Barry Song <21cnbao@gmail.com> wrote:

> it seems there is not an actual example that gpio requests pin from
> pinctrl yet. i might give one on SiRFprimaII.

No good example yet, no.

The reason is that for the U300 that I use as guinea pig, the
GPIO driver is tangled up in discussions about how to handle
the special control mechanics like requesting muxing and
biasing pins. Right now it seems easier to rewrite all that
to use the new pinctrl subsystem rather than actually trying
to work it into the GPIO subsystem first and refactor from
there, and that needs quite a bit of upfront work...

Linus Walleij
