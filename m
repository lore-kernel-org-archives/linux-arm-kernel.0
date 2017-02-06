From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Feb 2017 18:46:35 +0100
Subject: [PATCH 3/9] ARM: sunxi: Rename pwm0_pins to match our usual
 pattern
In-Reply-To: <CAGb2v64tnnG-CTF1C5yqj=VTmB-J_E9dH6Sit8fvWJD-ddw13A@mail.gmail.com>
References: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
 <d78adf8ff6ceedadeda235b3abda73f8bc87d377.1486320544.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v64tnnG-CTF1C5yqj=VTmB-J_E9dH6Sit8fvWJD-ddw13A@mail.gmail.com>
Message-ID: <20170206174635.wvl7fnxjhmr6e7zc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2017 at 03:15:15PM +0800, Chen-Yu Tsai wrote:
> On Mon, Feb 6, 2017 at 2:49 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The pwm0_pins group name is suggesting that this is the only option usable
> > for the PWM0 on the SoCs it's declared on. However, this is not the case
> > and defining a second pwm0 group would be quite weird given the name of the
> > first group.
> 
> Can you elaborate on the second pwm0 option? I'm not seeing it in my datasheets.

Hmmmm, I'm not sure why I did that anymore, looks like you're right...

I'll drop this one, and queue the others for 4.12.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170206/9b484d86/attachment.sig>
