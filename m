From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 15 Sep 2009 08:30:12 +0200 (CEST)
Subject: What's inside the pxa tree for this merge window
In-Reply-To: <20090914111152.GD16644@n2100.arm.linux.org.uk>
References: <f17812d70909100446h17a1903fy74941945dbfc6943@mail.gmail.com>
	<Pine.LNX.4.64.0909141259290.4359@axis700.grange>
	<20090914111152.GD16644@n2100.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0909150829100.4640@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Sep 2009, Russell King - ARM Linux wrote:

> On Mon, Sep 14, 2009 at 01:03:33PM +0200, Guennadi Liakhovetski wrote:
> > Hi Eric,
> > 
> > On Thu, 10 Sep 2009, Eric Miao wrote:
> > 
> > > Here's the preview of request-pull result, please let me know if there
> > > is anything missed, thanks.
> > > 
> > > URL: git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git
> > 
> > [snip]
> > 
> > > Guennadi Liakhovetski (3):
> > >       [ARM] pxa/pcm990: convert pcm990 to soc-camera as platform-device
> > >       [ARM] pxa/mioa701: convert mioa701 to the new platform-device soc-camera interface
> > >       [ARM] pxa/em-x270: convert em-x270 to soc-camera as platform-device
> > 
> > Could you please try to push your tree to Linus as early in the merge 
> > cycle as possible? The v4l tree depends on the above patches, and sh 
> > depends on v4l. Is your tree going to Linus via Russell or directly?
> 
> The request was for me to merge it into my tree.  However, last Saturday
> I asked Linus to pull my tree... still waiting, so I'm not going to merge
> anything further until that's reached some resolution.
> 
> It's a very bad idea to change trees after a pull request has been sent.

Ic, Eric, when would you be pushing your tree then?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
