From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Sep 2018 12:35:42 +0300
Subject: [PATCH v2 0/8] drm/bridge: add bus flag support
In-Reply-To: <CACRpkdZdxLMkECq8BBJHDqKszHPMt2uUPFbwbPVNKXyxu-SWGQ@mail.gmail.com>
References: <20180912183222.25414-1-stefan@agner.ch>
 <CACRpkdZdxLMkECq8BBJHDqKszHPMt2uUPFbwbPVNKXyxu-SWGQ@mail.gmail.com>
Message-ID: <4703489.BS6gAglWfc@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, 14 September 2018 12:07:03 EEST Linus Walleij wrote:
> On Wed, Sep 12, 2018 at 8:32 PM Stefan Agner <stefan@agner.ch> wrote:
> > @Linus Walleij, Laurent Pinchart: Since you have been involved in
> > the initial bus timings discussion, I would like to have your Ack
> > on at least patch 2/3... If we want to keep the setup/hold timings,
> > the patchset should also work without those two patches.
> 
> AFAICT this ends up with the PL111 code identical to what I
> proposed in my first patch set to support the latching properly,
> so I am pretty much happy as long as my hardware does not
> flicker. (Rough consensus and running code.) I'm not very invested
> in either idea to represent these timings, so
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

I've just replied to patch 3/8 with an explanation of why we have added this 
particular API, and why we need to keep it.

-- 
Regards,

Laurent Pinchart
