From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 Mar 2015 09:25:23 +0100
Subject: [PATCH 6/9] ARM: dt: dove: add Dove PMU DT entry to dove.dtsi
In-Reply-To: <5508439F.4000507@gmail.com>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YW7tB-0003mM-1L@rmk-PC.arm.linux.org.uk>
 <55072092.9040207@free-electrons.com>
 <20150317134335.GV8656@n2100.arm.linux.org.uk>
 <5508439F.4000507@gmail.com>
Message-ID: <CACRpkdaCZmvPK6YbFObNfNNs7ZNn=3dQEydftW2beZ63d4-eKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 4:09 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> If we do this, we should have a look at syscon and potentially also
> simple-mfd which will allow us to share the registers and register
> platform_devices for the sub-nodes.

I've just sent a pull request for simple-mfd to the ARM SoC
maintainers. I see that you Free Electron guys make good use
of it.

Yours,
Linus Walleij
