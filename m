From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 11 Sep 2018 09:48:27 +0300
Subject: omap4: support for manually updated display
In-Reply-To: <20180910174453.GV5662@atomide.com>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com> <3205865.8O8aibZXye@avalon>
 <20180910174453.GV5662@atomide.com>
Message-ID: <42986939-9670-df31-8f30-b0bfbf559d90@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/18 20:44, Tony Lindgren wrote:

>> I want to make it clear that I don't want to claim any privilege in getting 
>> patches merged first. I am however worried that, without an easy way to test 
>> DSI support, and without enough time to focus on it, I would break whatever 
>> would be merged now in future reworks. I would thus like to find out how to 
>> collaborate on this task, hopefully to move towards usage of drm_bridge and 
>> drm_panel for DSI-based pipelines.
> 
> Real users with mainline kernel with a real product should
> always have priority over any ongoing clean-up.

If this were cleanup, it would of course be a low priority work. But
this is changing omapdrm to support DRM panels and bridges, which is
needed to support many real products in the mainline kernel.

Droid/N9 are no exceptions here, I have been keeping support for
multiple boards out of mainline for this same reason: I don't want to
add omapdrm specific code that will need to be rewritten and would
complicate this big change. Well, Droid/N9 are different in the sense
that they are much more complex cases than the boards I've been keeping out.

In any case, Laurent was ok with merging the patches, so let's merge
them after rebasing.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
