From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 Jan 2014 16:11:47 +0000
Subject: PWM...
In-Reply-To: <20140120001446.GD9752@verge.net.au>
References: <20140119164956.GR15937@n2100.arm.linux.org.uk>
 <CAOesGMi7g=PHjzhkuObkeu+P_c6kUz5uFcND7euafUW56CvsnQ@mail.gmail.com>
 <20140119193026.GS15937@n2100.arm.linux.org.uk>
 <201401192126.41543.arnd@arndb.de>
 <20140120001446.GD9752@verge.net.au>
Message-ID: <20140120161147.GS17314@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 09:14:46AM +0900, Simon Horman wrote:
> On Sun, Jan 19, 2014 at 09:26:40PM +0100, Arnd Bergmann wrote:

> > Right: if you change an existing dts file from #pwm-cells=<2> to
> > #pwm-cells=<3>, that requires changing all references to the pwm

> Would this change imply that old dtbs would no longer work with new kernels?

So long as the code can still handle both values for #pwm-cells existing
DTBs should work fine.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140120/54d626fe/attachment.sig>
