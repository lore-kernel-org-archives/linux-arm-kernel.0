From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 13 Feb 2012 12:01:14 -0800
Subject: [PATCH 0/3] pinctrl: move the core per-device handlers to core
In-Reply-To: <CACRpkdYm3sb7wbJP1M9HmjkGHq1YuT06ar6-+V1RoZ1QdoT9BA@mail.gmail.com>
References: <1328814050-22715-1-git-send-email-linus.walleij@linaro.org>
 <4F34A3EF.3070207@nvidia.com>
 <CACRpkdZ0kTXLAfdsfMjeZZX4W-fx5zyEdeGboKCmKSzCaMVw_A@mail.gmail.com>
 <4F360853.3050402@nvidia.com>
 <CACRpkdYm3sb7wbJP1M9HmjkGHq1YuT06ar6-+V1RoZ1QdoT9BA@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178EF838ED@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Monday, February 13, 2012 12:48 PM:
> On Sat, Feb 11, 2012 at 7:18 AM, Stephen Warren <swarren@nvidia.com> wrote:
> 
> > I'll probably want to rework the 3 patches your changes break anyway (in
> > order to completely remove use of board-*-pinmux.c when booting from DT,
> > once I write the DT code) and so you may as well not apply them, just
> > the driver itself. It'll save some churn.
> 
> OK will that happen for this merge window or is the driver going to sit
> unused for the 3.4 cycle?
> 
> I'm mainly thinking if the underlying driver may be subject to change I
> could just keep it out-of-tree, unless you want it merged in for some
> practical reason, then I'll just merge it.

IIRC, people hoped that the common pinctrl bindings would make it into
3.4. If that happens, the driver won't be unused in 3.4.

I don't foresee any changes to the driver except those driven by any
changes to the core pinctrl itself, so I don't foresee any need to keep
it out of tree.

-- 
nvpublic
