From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Jun 2013 10:50:04 +0200
Subject: [EXAMPLE PATCH] pinctrl: add pinctrl driver for Rockchip SoCs
In-Reply-To: <51B619B9.8040204@wwwdotorg.org>
References: <201306090159.05383.heiko@sntech.de>
 <201306090201.17739.heiko@sntech.de>
 <CACRpkdaEcZZ3NZzwKOhUPjvFg+bSZ=UbpyPT2EBcAfVv1-EsKA@mail.gmail.com>
 <51B619B9.8040204@wwwdotorg.org>
Message-ID: <CACRpkdYT08w-3KuMD9YLcjebcpbqyOpWdqH5NU+fjAeP6VpkWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 8:23 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> The entire reason I created the <dt-bindings/> directory (rather than
> just putting *.h into e.g. arch/arm/boot/dts) was to provide a place to
> share binding-defined constants between the DT files and drivers that
> implement that binding. It's certainly my opinion that if/when *.dts
> move out of the kernel, the <dt-bindings/> directory should continue to
> be present in the kernel, and take updates mirrored from the upstream
> binding repo.

OK thanks Stephen, makes perfect sense.

Yours,
Linus Walleij
