From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Mar 2012 20:22:46 +0800
Subject: [GIT PULL] imx irq_domain migration
In-Reply-To: <CACxGe6tsHWj+bHcg1uEV8x-KE7B8p1Lj-_DL9mysYn1z+Bex3g@mail.gmail.com>
References: <20120216154941.GB11758@r65073-Latitude-D630>
 <4F3D41D2.5090203@gmail.com>
 <20120314050837.GB21337@S2101-09.ap.freescale.net>
 <4F6098C6.7050503@gmail.com>
 <CACxGe6tsHWj+bHcg1uEV8x-KE7B8p1Lj-_DL9mysYn1z+Bex3g@mail.gmail.com>
Message-ID: <20120316122243.GH7758@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 09:44:26AM -0600, Grant Likely wrote:
> On Wed, Mar 14, 2012 at 7:10 AM, Rob Herring <robherring2@gmail.com> wrote:
> > On 03/14/2012 12:08 AM, Shawn Guo wrote:
> >> On Thu, Feb 16, 2012 at 11:50:10AM -0600, Rob Herring wrote:
> >>> Shawn,
> >>>
> >>> On 02/16/2012 09:49 AM, Shawn Guo wrote:
> >>>> Hi Rob,
> >>>>
> >>>> Please pull imx irq_domain support below. It's based on Grant's
> >>>> irqdomain/next today with your generic-chip series applied on top
> >>>> of it.
> >>>
> >>> You're asking me to pull changes on top of a branch that I don't even
> >>> have as you've rebased my changes. While it would work I don't think
> >>> this is the right flow. Plus there is not really any reason for iMX
> >>> changes to go thru me.
> >>>
> >>> Either Grant needs to stabilize his branch so you and I can send him
> >>> pull requests or he can pull in our changes and rebase them as he
> >>> rebases. I already asked him to do just that with my 1 patch others are
> >>> dependent on.
> >>>
> >> Hi Grant,
> >>
> >> Would you consider to take this request after you take Rob's
> >> generic_irq one?
> >
> > You'll need rebase your branch as I did since Grant did.
> 
> Also, the imx changes should go via the arm-soc tree, not the
> irqdomain/next branch.  irqdomain/next is stable now, so you can use
> it as your base.  Rebase your changes on top of it and ask Arnd or
> Olof to pull the result into an arm-soc branch.
> 
Okay.  Since imx change has a dependency on Rob's change, I have to
wait until Rob's change shows up on irqdomain/next.

-- 
Regards,
Shawn
