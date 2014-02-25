From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Feb 2014 10:36:54 +0100
Subject: [PATCH 00/10] pinctrl: mvebu: remove hard-coded addresses from
 Dove pinctrl
In-Reply-To: <20140224181023.GA1010@titan.lakedaemon.net>
References: <1393231382-11078-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140224181023.GA1010@titan.lakedaemon.net>
Message-ID: <CACRpkdZ+YGTyDj6i8c198MdRtz3GY-YBmVO9LysPCcmT4EC0cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 7:10 PM, Jason Cooper <jason@lakedaemon.net> wrote:

> Sebastian, Linus,
>
> I've now created mvebu/pinctrl-dove for this series.  It's based on
> v3.14-rc1, and depends on mvebu/pinctrl (which depends on
> mvebu/pinctrl-3xx).
>
> I've kept this series in a separate branch in case we encounter an
> unforeseen problem with something in here.  Then this branch can be
> dropped, and /pinctrl-3xx and /pinctrl will still make it in.
>
> So, all patches except 3 and 4 are in mvebu/pinctrl-dove.  3 and 4 are
> in mvebu/dt.

OK so what should I be pulling in first now?

Yours,
Linus Walleij
