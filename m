From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 22 Aug 2011 12:59:16 -0700
Subject: [RFC PATCH 0/2] WIP: generic OF pinmux binding
In-Reply-To: <1313581648-22303-1-git-send-email-jamie@jamieiles.com>
References: <1313581648-22303-1-git-send-email-jamie@jamieiles.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B24A368D@HQMAIL01.nvidia.com>
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

Thanks very much. These patches look sane to me. I'll pick them up in my
local tree, enhance them to support the pins/additional-pins property that
I just mentioned in a separate email, retest and repost.

> This doesn't address the runtime muxing that LinusW's set of patches do,
> and I'm not sure how to handle that.

I see that LinusW just posted another version of this. I'll go check that
out too, in case it has any impact on these patches.

-- 
nvpublic
