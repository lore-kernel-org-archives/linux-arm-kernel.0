From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 Oct 2015 10:11:52 +0900
Subject: [PATCH RESEND v6 0/2] ARM: sunxi: Add Reduced Serial Bus (RSB)
 controller support
In-Reply-To: <CAGb2v66utAE-Pzmn7dNuWOCGV-Y_=U9sfhGh=Cey-J-Y9BNHpg@mail.gmail.com>
References: <1445625691-20289-1-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v66utAE-Pzmn7dNuWOCGV-Y_=U9sfhGh=Cey-J-Y9BNHpg@mail.gmail.com>
Message-ID: <20151026011152.GH14238@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 24, 2015 at 11:30:32AM +0800, Chen-Yu Tsai wrote:
> Hi Arnd, Kevin, Olof,
> 
> On Sat, Oct 24, 2015 at 2:41 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi Arnd, Kevin, Olof,
> >
> > As discussed on IRC, here is a resend of these RSB patches, to merge
> > for 4.4.
> 
> Please merge them on a topic branch, so we can try to merge other
> patches depending on them. If possible I'd like to get an actual
> user in 4.4, otherwise this driver won't get any usage until the
> next merge window.
> 
> I'll try to send out a new version of the AXP223 patches later today.

It's too late to make 4.4, rc7 is upon us. But the good news is that for 4.4
there's no need to add cross-tree dependencies to get the shared base, which
is a good thing.

So, given timing I'll apply these directly without a topic branch.


-Olof
