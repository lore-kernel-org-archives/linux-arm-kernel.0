From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 9 Apr 2018 19:46:19 +0800
Subject: [PATCH 1/7] ARM: multi_v7_defconfig: add OCOTP driver for NXP SoCs
In-Reply-To: <CAK8P3a2xhOEVF87WYCPLiw66XM1ydA9JCbf+2s4ZDApw9V5STQ@mail.gmail.com>
References: <20180318203442.19759-1-stefan@agner.ch>
 <20180326073214.GB8857@dragon>
 <CAK8P3a2xhOEVF87WYCPLiw66XM1ydA9JCbf+2s4ZDApw9V5STQ@mail.gmail.com>
Message-ID: <20180409114618.GB14582@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 03:40:33PM +0200, Arnd Bergmann wrote:
> On Mon, Mar 26, 2018 at 9:32 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> > On Sun, Mar 18, 2018 at 09:34:36PM +0100, Stefan Agner wrote:
> >> Enable on-chip OTP NVMEM support for NXP i.MX and VF610 SoCs.
> >> Since OTP values might be required by drivers required during
> >> boot, make sure the driver is built-in (e.g. i.MX thermal
> >> driver).
> >>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >
> > Arnd,
> >
> > The series looks good to me.  In general, I keep myself away from
> > multi_v7_defconfig changes, but if you expect a pull-request from me, I
> > can do that.  Let me know how you want to apply the patches.
> 
> I would generally prefer that your defconfig pull requests contain changes
> to both the imx specific and the generic defconfig files. It's much easier
> for me to handle any conflicts when they arise during a merge than
> to pick up the individual patches.

Noted, thanks for the comments, Arnd.

Shawn
