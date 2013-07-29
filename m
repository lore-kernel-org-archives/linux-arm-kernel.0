From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 29 Jul 2013 20:38:52 +0200
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130729073123.GB1441@lukather>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <1441731.8CGUI1tUxh@flatron> <20130728085650.GA4683@netboy>
 <1416484.XDfk5G56BI@flatron> <20130728131901.GA8864@netboy>
 <20130729073123.GB1441@lukather>
Message-ID: <20130729183851.GB4209@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 09:31:23AM +0200, Maxime Ripard wrote:
> 
> I'm afraid this kind of use case will never be properly supported, DT
> stable ABI or not.
> 
> Think about this: what kernel will actually be shipped in that board?
> Most likely, it will be a BSP kernel from the vendor. Does the vendor
> will have made that commitment to have a stable ABI for the DT? Will it
> use the same bindings than mainline? Do we want to support all the crazy
> bindings every vendor will come up with?
> 
> I'm afraid the answer to these three questions will most of the time be
> "no.".

Yes, I know, and it is sad but true.
 
We can't stop the vendors from shipping half-baked BSPs. I really
don't mind that they do that. After all, they want to get *something*
working when they launch their chips.

> That doesn't mean we shouldn't aim for *mainline* having a stable DT
> ABI, but that kind of use case doesn't seem very realistic to me.

Right, we can and should do better. I got the beaglebone Ethernet
working in mainline (not by writing the driver, but by complaining
over and over again). I except that it will continue to work and not
fall victim to some random DT change.

Thanks,
Richard
