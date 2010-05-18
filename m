From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 18 May 2010 06:53:19 +0100
Subject: Samsung SoCs framebuffer re-work
In-Reply-To: <AANLkTimfbcYLyiuErIMcDqfAzz2L76J3j2IxlWS0b333@mail.gmail.com>
References: <AANLkTinThrLrsxBYHs-1xPqIaRiK1HH-YZkcloKHnzkx@mail.gmail.com>
	<20100518025058.GL27571@trinity.fluff.org>
	<AANLkTimfbcYLyiuErIMcDqfAzz2L76J3j2IxlWS0b333@mail.gmail.com>
Message-ID: <20100518055319.GP27571@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 12:09:25PM +0900, Kyungmin Park wrote:
> On Tue, May 18, 2010 at 11:50 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> > On Tue, May 18, 2010 at 08:59:29AM +0900, Kyungmin Park wrote:
> >> Hi Ben,
> >>
> >> Currently there's only one fb drivers for samsung SocS. but it's based
> >> on s3c24xx and a part of s3c64xx.
> >
> > Your statement is incorrect, we have the s3c2410-fb driver which deals
> > with the 2410/2440/2412 style hardware and s3c-fb which is for the newer
> > devices.
> 
> Yes it's working on s5pc110. I mean it's not fit the platform requirement.

?
 
> >
> >> As you can see the s5pc110 (aka s5pv210) spec, It has more features
> >> and interconnection between FIMC and FIMD.
> >> So current fb driver can't handle these features well. So LSI make a
> >> own fb drivers and use it. You can see the code at their git repo.
> >>
> >> Now we are re-implement or change it for s5pc110 and for future usages.
> >> How do you think?
> >
> > I've already got updates for s3c-fb to work on 2416,2443 and the c110/v210
> > systems. I am talking with the relevant people at System.LSI to get our
> > drivers closers together, possibly we can get this done for the current
> > merge window.
> 
> You mean you want to use the current fb drivers for s5pc110 also?
> Then how to do implement features mentioned by Kukjin?

Well, apart from the fact that quite a lot of them are actually features
that are in all versions of this block, we intend to create some patches
and send them to the relevant lists...

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
