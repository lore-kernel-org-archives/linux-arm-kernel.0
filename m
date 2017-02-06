From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Feb 2017 18:37:31 +0100
Subject: [PATCH 4/9] ARM: sun5i: Add UART2 pin group
In-Reply-To: <CAGb2v65C9Bs0NAM4A_1fbjoDDeNuVM0h-=i2zdF6EXgLqnxHUg@mail.gmail.com>
References: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
 <1da35c92609058bff5e2b4d56d8940c2919f594d.1486320544.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65C9Bs0NAM4A_1fbjoDDeNuVM0h-=i2zdF6EXgLqnxHUg@mail.gmail.com>
Message-ID: <20170206173731.m7p4gyauilbqoz33@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 06, 2017 at 03:17:40PM +0800, Chen-Yu Tsai wrote:
> On Mon, Feb 6, 2017 at 2:49 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > There's one UART2 pin group that can be used across all sun5i SoCs.
> > However, the A10s already has one pin group for that controller.
> >
> > Change the index of the one in the A10s DTSI, and add the common one to
> > sun5i.dtsi
> 
> Kind of goes against the tradition of not adding stuff no one uses?
> Perhaps add a comment instead? I'm OK either way though.

Not really, this is used by the CHIP Pro.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170206/4918cee3/attachment.sig>
