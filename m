From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 23:11:02 +0200
Subject: [PATCH 1/2] gpiolib: add gpio_export_with_name
In-Reply-To: <51A7B8CD.4080702@epfl.ch>
References: <20121121101259.GQ4398@game.jcrosoft.org>
 <1353492849-29397-1-git-send-email-plagnioj@jcrosoft.com>
 <20121126135911.2F1D33E187C@localhost> <51A719A5.50906@epfl.ch>
 <CACRpkdb9F+wJ0hkNqPTP34r3JAEp2s07Q8U24fD6oCdj7MqCFA@mail.gmail.com>
 <51A7B8CD.4080702@epfl.ch>
Message-ID: <CACRpkdZMj-Xin5PMDWavaWOTCSZF3NBWXk4fG4QXsJzhwBcs_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 10:38 PM, Florian Vaussard
<florian.vaussard@epfl.ch> wrote:

> Indeed, I work in a robotics lab :-) One of our board (mach-imx/
> mx31moboard*.c) controls for example the multiplexing of two cameras
> sharing the same acquisition bus (I know, a bit hackish).
> I developed a similar board with an OMAP3. Such control do not
> fit well in the above-mentioned cases, but we do not need RT processes.

It does seem to fit well with V4L and/or the media controller
framework though, or is this one of those "oh, we don't really
like to use V4L so we have this special hack instead" things?

Yours,
Linus Walleij
