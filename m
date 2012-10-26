From: vkoul@infradead.org (Vinod Koul)
Date: Fri, 26 Oct 2012 14:40:56 +0530
Subject: [PATCH V3 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <CAKohpo=4QDBuFZJrdCkXzijx4aD0rNXf1X2wS9LG17zg_LeAYg@mail.gmail.com>
References: <3100e691db3f94c22afd98b609a1568d7e70dfe7.1350360935.git.viresh.kumar@linaro.org>
 <169edae67b9a051ca7448e5b62c3cd2c5c1db470.1350360935.git.viresh.kumar@linaro.org>
 <CAKohpokEXAGD-nUF6u8tugvF2ffJx3HLLd+Zgc2+6GB9hxnT6Q@mail.gmail.com>
 <1351241315.7077.16.camel@vkoul-udesk3>
 <CAKohpo=4QDBuFZJrdCkXzijx4aD0rNXf1X2wS9LG17zg_LeAYg@mail.gmail.com>
Message-ID: <1351242656.7077.20.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-10-26 at 14:35 +0530, Viresh Kumar wrote:
> >> I can see that you applied these patches and they are present in
> >> linux-next. But i feel
> >> the order of patches is bad.
> > Yes looks like I forgot to sort the mbox series :(
> >
> > since all patches were applied nicely, and they seem fairly independent
> > of each other it should cause issue. Let me know if you wnat me to redo
> > my -next.
> 
> yes. The ARCH specific patch 3/3 uses a routine created in 2/3. So they have
> to be in right order for git bisect to work. 

Done, it should reflect now.
Sorry for the mess.

-- 
Vinod Koul
Intel Corp.
