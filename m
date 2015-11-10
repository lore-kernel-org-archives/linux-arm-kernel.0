From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 10 Nov 2015 10:09:09 +0000
Subject: [RFC PATCH v3 1/4] drm: Introduce generic probe function for
 component based masters.
In-Reply-To: <5641B075.6020602@rock-chips.com>
References: <1445267270-23126-1-git-send-email-Liviu.Dudau@arm.com>
 <1445267270-23126-2-git-send-email-Liviu.Dudau@arm.com>
 <564069CD.2070102@rock-chips.com>
 <20151109114259.GX8644@n2100.arm.linux.org.uk>
 <20151109115727.GE963@e106497-lin.cambridge.arm.com>
 <5641B075.6020602@rock-chips.com>
Message-ID: <20151110100909.GI963@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 04:53:09PM +0800, Mark yao wrote:
>    On 2015?11?09? 19:57, Liviu Dudau wrote:
> 
>  Meanwhile, what is your suggestion regarding the patchset. I've seen David has
>  sent Linus a pull request for 4.4-rc1 that includes it. Should we send a
>  revert for rockchip commit and then patch later the function?
> 
>    Hi Liviu
>    ??? I had sent a patch to revert this rockchip commit, verfied rockchip drm works. So we can do the fix later.

Yeah, and I'm thinking about ACK-ing it. On one hand I would like to
have this fixed, on the other hand I don't want the rockchip platform
to be broken. But looking at the rest of the changes I need to do it
doesn't feel right to make you wait for them.

Best regards,
Liviu

> 
>    Thanks all the same. :-)
> 
>    -- ?ark Yao

> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
