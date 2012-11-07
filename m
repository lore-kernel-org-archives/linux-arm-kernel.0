From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 7 Nov 2012 21:30:28 +0100
Subject: [PATCH] pwm: lpc32xx - Add a driver for the motor PWM
In-Reply-To: <509A982A.6020401@antcom.de>
References: <1352305828-25298-1-git-send-email-alban.bedel@avionic-design.de>
 <509A982A.6020401@antcom.de>
Message-ID: <20121107203028.GA6186@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 06:19:38PM +0100, Roland Stigge wrote:
> On 07/11/12 17:30, Alban Bedel wrote:
> > Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
> > ---
> >  .../devicetree/bindings/pwm/lpc32xx-motor-pwm.txt  |   24 ++
> >  arch/arm/boot/dts/lpc32xx.dtsi                     |    7 +
> 
> Is all this supposed to go via mach-lpc32xx -> arm-soc.git? Then, I can
> take this into the lpc32xx tree. Otherwise, you can split off the .dtsi
> file and I include it via lpc32xx.

I'd prefer a split between the arch/arm changes and the rest. I'll take
the drivers/pwm and Documentation changes through the PWM tree.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121107/61af1347/attachment.sig>
