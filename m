From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 7 Aug 2014 11:08:23 +0800
Subject: [PATCH] ARM: mx6: Fix suspend/resume with PCI
In-Reply-To: <CAOMZO5A0zwfr3+bo2RibMYF883aqx8LUb+8TN+uy79VtrwqVVA@mail.gmail.com>
References: <1407371998-11437-1-git-send-email-festevam@gmail.com>
 <20140807021831.GM2167@dragon>
 <CAOMZO5A0zwfr3+bo2RibMYF883aqx8LUb+8TN+uy79VtrwqVVA@mail.gmail.com>
Message-ID: <20140807030822.GN2167@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 11:52:29PM -0300, Fabio Estevam wrote:
> On Wed, Aug 6, 2014 at 11:18 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> 
> > I intend to agree with Lucas that we should align our testing and
> > understanding on the issue before trying to fix it.
> >
> > Again, I do not see this issue on my TO1.2 chip, but only TO1.5,
> > aka Rev 1.3, one.
> 
> Which version is your sabresd with TO1.2? Mine is rev C2 and the
> suspend/resume issue happens 100%.

The label on the board says it's Rev B.

Shawn
