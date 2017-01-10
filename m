From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 10 Jan 2017 11:42:48 +0100
Subject: [PATCH v5 1/2] ARM: dts: at91: add devicetree for the Axentia
 TSE-850
In-Reply-To: <b686fa42-bbfb-dec2-460f-ef00869bc12e@axentia.se>
References: <1484035732-31635-1-git-send-email-peda@axentia.se>
 <1484035732-31635-2-git-send-email-peda@axentia.se>
 <20170110092928.hwd4l4k3eyagepco@piout.net>
 <b686fa42-bbfb-dec2-460f-ef00869bc12e@axentia.se>
Message-ID: <20170110104248.iscurq55d7n26gfd@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2017 at 10:52:56 +0100, Peter Rosin wrote :
> On 2017-01-10 10:29, Alexandre Belloni wrote:
> > Hi,
> > 
> > This needs a commit message, please add one.
> 
> There's not all that much to say, but ok, I'll add something.
> 

It doesn't have to be long but it has to be present.

> > On 10/01/2017 at 09:08:51 +0100, Peter Rosin wrote :
> There's also the benefit of the increased chances of me getting
> notified of changes. I don't mind...
> 

Do you expect changes coming from third parties? I'm fine with it
anyway.

> >> +&main {
> >> +	clock-frequency = <12000000>;
> >> +};
> >> +
> > 
> > I don't think this is needed
> > 
> > 
> 
> "this"? The &main frequency, or all of them?
> 

I meant just main

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
