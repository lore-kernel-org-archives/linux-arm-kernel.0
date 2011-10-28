From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Oct 2011 22:03:34 +0200
Subject: [PATCH] pinctrl: Fix "warning: 'struct pinctrl_dev' declared
	inside parameter list"
In-Reply-To: <1319773104-3541-1-git-send-email-Barry.Song@csr.com>
References: <1319773104-3541-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdaG_J1pKhzsfbjAEv6AQ_V0q6w=VTyxf6ur5aQdAnK34A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2011 at 5:38 AM, Barry Song <Barry.Song@csr.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> when pinctl subsystem is not selected, when compiling drivers including
> the include/linux/pinctrl/pinctrl.h, we will get the warning as below:
> In file included from include/linux/pinctrl/pinmux.h:17,
> ? ? ? ? ? ? ? ? from drivers/tty/serial/sirfsoc_uart.c:25:
> include/linux/pinctrl/pinctrl.h:126: warning: 'struct pinctrl_dev'
> ? ? ? ? ? ? ? ?declared inside parameter list
> include/linux/pinctrl/pinctrl.h:126: warning: its scope is only this
> ? ? ?definition or declaration, which is probably not what you want
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

OK applied.

Thanks,
Linus Walleij
