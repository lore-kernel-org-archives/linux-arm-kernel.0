From: horms@verge.net.au (Simon Horman)
Date: Fri, 7 Aug 2015 09:40:48 +0900
Subject: [PATCH v2 0/2] Add R8A7794 GPIO DT support
In-Reply-To: <CAMuHMdV5F2JL6_OhPY3y7WZn_pfG_ufRUe9NA+2C-CGLtVxVaw@mail.gmail.com>
References: <6388101.Drn6rL87rl@wasted.cogentembedded.com>
 <20150806004714.GD17231@verge.net.au>
 <CAMuHMdV5F2JL6_OhPY3y7WZn_pfG_ufRUe9NA+2C-CGLtVxVaw@mail.gmail.com>
Message-ID: <20150807004048.GC1145@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 09:21:34AM +0200, Geert Uytterhoeven wrote:
> On Thu, Aug 6, 2015 at 2:47 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Aug 04, 2015 at 12:36:27AM +0300, Sergei Shtylyov wrote:
> >>    Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
> >> 'renesas-devel-20150803-v4.2-rc5' tag. Here we add the GPIO device tree support
> >> for the R8A7794 SoC.
> >>
> >> [1/2] ARM: shmobile: r8a7794: add GPIO clocks
> >> [2/2] ARM: shmobile: r8a7794: add GPIO DT support
> >
> > Thanks, I have queued these up for v4.4.
> 
> Woops, Since CPG/MSTP support is in, GPIO won't work, as the nodes
> lack "power-domains" properties.

Sorry for letting that through.
I will drop these patches accordingly.
Sergei, could you please re-spin them?
