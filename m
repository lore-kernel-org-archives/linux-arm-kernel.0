From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 17 Aug 2011 23:40:26 -0700
Subject: [RFC PATCH 0/2] WIP: generic OF pinmux binding
In-Reply-To: <1313581648-22303-1-git-send-email-jamie@jamieiles.com>
References: <1313581648-22303-1-git-send-email-jamie@jamieiles.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04AF6F3065@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Iles wrote at Wednesday, August 17, 2011 5:47 AM:
> To avoid going too far in the wrong direction I thought I'd post what I
> have so far for a generic pinmux binding.  Essentially it's just
> Stephen's nvidia binding but with the nvidia specifics abstracted out so
> the common loop can be used for other platforms.  This approach works
> nicely for picoxcell too.
> 
> For more esoteric bindings, such as pull strength, these could be
> handled in the platform specific configuration function.
> 
> This doesn't address the runtime muxing that LinusW's set of patches do,
> and I'm not sure how to handle that.

Just FYI, I'm at LinuxCon this week, so probably won't get a chance to
really look over these patches in detail until next week; I can't do them
justice at midnight:-)

-- 
nvpublic
