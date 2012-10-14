From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 14 Oct 2012 12:01:30 +0200
Subject: [PATCH V2 3/3] ARM: SPEAr13xx: Pass DW DMAC platform data from DT
In-Reply-To: <CAKohpokj0Up23YEDTuSOHDgqcCuM3Q21cwnkAz5Ya=JhPKM98A@mail.gmail.com>
References: <2039bc164224b0068bc078b6cd8df6218e754fce.1350051925.git.viresh.kumar@linaro.org>
 <20121012144837.GE12801@game.jcrosoft.org>
 <CAKohpo=vMchmiz70evBB5bPqt4O4DWUocd5M1o9gc8fsY_Fkiw@mail.gmail.com>
 <20121012162148.GH12801@game.jcrosoft.org>
 <CAKohpok5ZOmz9CCJbTGc=_tncxnZYEW7UMh2FcFcs0dB87JAcQ@mail.gmail.com>
 <20121013064422.GJ12801@game.jcrosoft.org>
 <CAKohpokfei_ryGKMh4wE9D=wyRZCkddc+Da1cq+3facTHradKQ@mail.gmail.com>
 <20121013122242.GL12801@game.jcrosoft.org>
 <CAKohpom-P+=QfVNBsypq70+o+z_5J63RD72DA-_CakTM9LDCNA@mail.gmail.com>
 <CAKohpokj0Up23YEDTuSOHDgqcCuM3Q21cwnkAz5Ya=JhPKM98A@mail.gmail.com>
Message-ID: <20121014100130.GM12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19:40 Sat 13 Oct     , Viresh Kumar wrote:
> On 13 October 2012 19:38, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 13 October 2012 17:52, Jean-Christophe PLAGNIOL-VILLARD
> > <plagnioj@jcrosoft.com> wrote:
> >> On 14:18 Sat 13 Oct     , Viresh Kumar wrote:
> >>>    On Oct 13, 2012 12:16 PM, "Jean-Christophe PLAGNIOL-VILLARD"
> >>>    <plagnioj@jcrosoft.com> wrote:
> >>>    >
> >>>    > On 22:42 Fri 12 Oct     , Viresh Kumar wrote:
> >>>    > > On 12 October 2012 21:51, Jean-Christophe PLAGNIOL-VILLARD
> >>>    > > <plagnioj@jcrosoft.com> wrote:
> >>>    > > >> >> +     OF_DEV_AUXDATA("arasan,cf-spear1340", MCIF_CF_BASE, NULL,
> >>>    "cf"),
> >>>    > > >> > ?/
> >>>    > > >>
> >>>    > > >> Sorry. can't get it :(
> >>>    > > > what is the "cf" as paltfrom data
> >>>    > >
> >>>    > > This is dma bus_id string, which matches with what is passed from dtb.
> >>>    > so pass if via dtb too
> >>>
> >>>    Yes. Already passed in 13xx.dtsi.
> 
> Probably some confusion here. What i meant to say here is, dmac's
> DT slave info has a node for cf and cf driver expects this string to come
> via platform data currently.

so use a phandle to connect them

Best Regards,
J.
