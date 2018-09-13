From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Sep 2018 09:40:55 +0200
Subject: [4.14.y] request commit 94a5d8790e79 ("arm64: cpu_errata: include
 required headers")
In-Reply-To: <20180913073822.GA31299@kroah.com>
References: <20180911170030.650928d8@xhacker.debian>
 <20180913071216.GH11496@kroah.com>
 <20180913152420.6c6324f4@xhacker.debian> <20180913073822.GA31299@kroah.com>
Message-ID: <CAK8P3a03PedvHW+Njkdsb-0khiTLYLtLfbQ26BwnHCrdNRKdAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 9:38 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Sep 13, 2018 at 03:24:20PM +0800, Jisheng Zhang wrote:
> > Hi Greg,
> >
> > On Thu, 13 Sep 2018 09:12:16 +0200 Greg Kroah-Hartman wrote:
> >
> > > On Tue, Sep 11, 2018 at 05:00:30PM +0800, Jisheng Zhang wrote:
> > > > Hi Greg,
> > > >
> > > > I think we missed the commit 94a5d8790e79 ("arm64: cpu_errata: include
> > > > required headers"), could you please include it in next stable release?
> > >
> > > Really, you are seeing build failures on 4.14.y without this patch
> > > applied?  I haven't gotten any reports of this, what is wrong with our
> >
> > yes. I see similar build errors as the commit mentioned. Per my test, setting
> > CONFIG_ARM64_SSBD as y will trigger the errors.
>
> Odd that no one else is seeing this, perhaps you might want to look into
> that :)
>
> Anyway, it's a safe patch, now queued up.

It's a fairly unusual configuration, but not hard to hit in randconfig
builds. I've been meaning to resume doing randconfig builds on stable
kernels for a while to catch more of those, hopefully after Linux Connect
I'll get to that.

      Arnd
