From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Nov 2018 11:29:01 -0800
Subject: [GIT PULL 0/3] arm64: tegra: Updates for v4.20-rc2
In-Reply-To: <20181108121627.GA1340@ulmo>
References: <20181107145350.29127-1-thierry.reding@gmail.com>
 <CAOesGMjcOQif8H6b5afKBwYstkbzGC7wuUcN2Srz=vJz11qSnA@mail.gmail.com>
 <20181108121627.GA1340@ulmo>
Message-ID: <20181113192901.wbug3ylflhz4z2kv@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 08, 2018 at 01:16:27PM +0100, Thierry Reding wrote:
> On Wed, Nov 07, 2018 at 08:31:55AM -0800, Olof Johansson wrote:
> > Hi Thierry,
> > 
> > On Wed, Nov 7, 2018 at 6:53 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> > >
> > > Hi ARM SoC maintainers,
> > >
> > > These pull requests are some follow-up changes to finally enable the
> > > generic power domains for the Tegra XUSB block. This builds on top of
> > > changes that were merged into v4.20-rc1, but because of some non-
> > > trivial runtime dependencies I decided to hold back on these until
> > > after the dust had settled.
> > >
> > > Do you think it would be possible to merge these in for v4.20-rc2? I
> > > realize that they are not actually fixes, but they merely add a couple
> > > of lines to enable the power domains for XUSB as well as the
> > > corresponding DT bindings.
> > 
> > Is anything broken without these changes, or is it more that the
> > dependency have landed and you're itching to get things enabled?
> > 
> > If it's the former we should chat (since it's an unfortunate
> > situation). If it's the latter I'm happy to queue them up for the next
> > merge window.
> 
> Nothing's broken without these changes, but I figured that these two
> dozen lines could still make it into v4.20. I know that this has
> occasionally been done in the past for very small enablement patches
> if they were small enough. I could've communicated this a little
> earlier, so that this wouldn't have come as a bit of a surprise.
> 
> If you prefer to defer this to v4.21 that's totally fine. I can queue
> them up in my tree for the next merge window, no need for you to pick
> this up in pieces.

Ok, let's queue them for 4.21 at this point. Thanks!


-Olof
