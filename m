From: horms@verge.net.au (Simon Horman)
Date: Tue, 21 Jan 2014 09:39:22 +0900
Subject: PWM...
In-Reply-To: <20140120161147.GS17314@sirena.org.uk>
References: <20140119164956.GR15937@n2100.arm.linux.org.uk>
 <CAOesGMi7g=PHjzhkuObkeu+P_c6kUz5uFcND7euafUW56CvsnQ@mail.gmail.com>
 <20140119193026.GS15937@n2100.arm.linux.org.uk>
 <201401192126.41543.arnd@arndb.de>
 <20140120001446.GD9752@verge.net.au>
 <20140120161147.GS17314@sirena.org.uk>
Message-ID: <20140121003922.GA31997@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 04:11:47PM +0000, Mark Brown wrote:
> On Mon, Jan 20, 2014 at 09:14:46AM +0900, Simon Horman wrote:
> > On Sun, Jan 19, 2014 at 09:26:40PM +0100, Arnd Bergmann wrote:
> 
> > > Right: if you change an existing dts file from #pwm-cells=<2> to
> > > #pwm-cells=<3>, that requires changing all references to the pwm
> 
> > Would this change imply that old dtbs would no longer work with new kernels?
> 
> So long as the code can still handle both values for #pwm-cells existing
> DTBs should work fine.

Thanks, as long as that is the case I have no objections at this time.
