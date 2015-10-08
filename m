From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 8 Oct 2015 14:36:30 +0200
Subject: [PATCH] KVM: arm/arm64: Add VGICv3 save/restore API documentation
In-Reply-To: <009501d101c4$dde8e2e0$99baa8a0$@samsung.com>
References: <1444247430-14808-1-git-send-email-christoffer.dall@linaro.org>
 <003a01d10199$58e96590$0abc30b0$@samsung.com>
 <20151008082302.GE14315@cbox>
 <005e01d101a9$31ee80f0$95cb82d0$@samsung.com>
 <20151008092858.GA16100@cbox> <561641F5.4060202@arm.com>
 <009501d101c4$dde8e2e0$99baa8a0$@samsung.com>
Message-ID: <20151008123630.GC20936@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 03:28:40PM +0300, Pavel Fedin wrote:
>  Hello!
> 
> > Well, compatibility with GICv2 is the biggest mistake we made when
> > designing the GICv3 architecture. And that's why our emulation doesn't
> > give a damn about v2 compatibility.
> 
>  Ok, i see your arguments, and after that it becomes a matter of personal taste. Three beat one, i
> go your way. :) Don't know if i'll be able to roll out v5 tomorrow, but i think on monday i'll
> definitely do.
> 
There's no rush, I don't think this will make it into v4.4 anyhow, as
we're already on -rc4 and there's a bunch of other stuff in flight, and
I haven't configured a way to test these patches yet.

Speaking of which, does the QEMU side of this patch set require first
adding the GICv3 emulation for the data structures or is there a
stand-alone migration patch set somewhere?

-Christoffer
