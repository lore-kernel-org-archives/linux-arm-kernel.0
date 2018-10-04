From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 4 Oct 2018 17:02:37 +0200
Subject: [PATCH] arm64: dts: allwinner: a64: Re-add "syscon" compatible
In-Reply-To: <22014c5e-fee0-d4c6-bc6c-cd30c8545292@arm.com>
References: <20180917152857.162662-1-andre.przywara@arm.com>
 <CAGb2v643=V_3DbLeEyXEavSQJsW2KdknpZZLfw4QwCjhfdmVsA@mail.gmail.com>
 <20180921153522.0413c280@donnerap.Emea.Arm.com>
 <20180921151625.wkaypyueyi2pguur@flea>
 <20180924112230.73e3009b@donnerap.Emea.Arm.com>
 <20180926095202.tdibor3x7fsn6afz@flea>
 <22014c5e-fee0-d4c6-bc6c-cd30c8545292@arm.com>
Message-ID: <20181004150237.hsvytl6iycow5xyo@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2018 at 01:55:19AM +0100, Andr? Przywara wrote:
> >> So I am sorry if those things frustrate you (which I can understand
> >> very well), but I believe fixing the DT in a proper way is
> >> much more user friendly in the long term (actually this issue was
> >> brought forward by a user[1]).
> > 
> > Given the current state of the industry, I don't really see how the DT
> > can allow you to do what you are trying to achieve.
> 
> I am not sure I do understand what you mean with "industry"? If you are
> thinking about the SoC vendor or board vendors to push this endeavor and
> create stable bindings and DTs from the beginning: I see that this won't
> work with the prevalent attitude across many vendors today.

This is what I meant.

> But in our case we (as the community) drive the DTs and the bindings
> anyway, and we decided to mostly ignore Allwinner's DT effort - for good
> reasons. So we can - given consensus on the goals and approach - make
> this possible and don't need to rely on any company or "industry".

Actually, I think this is part of the reason. We like our DT bindings
so much that we are ready to spend monthes debating on it, while with
ACPI (or the DT from the older days, from what I understood) you're
stuck with whatever comes with the board. Whether one likes it or not
doesn't matter. And then you can use whatever kernel with it.

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181004/80ce8460/attachment.sig>
