From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 10 Oct 2016 10:15:26 +0300
Subject: [PATCH v5 2/5] drm/bridge: Add RGB to VGA bridge support
In-Reply-To: <04679d93-ae58-7c94-616e-2eec23e84d6e@codeaurora.org>
References: <20160930143709.1388-1-maxime.ripard@free-electrons.com>
 <20161007091444.GO4684@lukather>
 <04679d93-ae58-7c94-616e-2eec23e84d6e@codeaurora.org>
Message-ID: <2147837.toaTVtNybe@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Archit,

On Monday 10 Oct 2016 11:05:10 Archit Taneja wrote:
> On 10/07/2016 02:44 PM, Maxime Ripard wrote:
> > On Fri, Oct 07, 2016 at 10:27:31AM +0530, Archit Taneja wrote:

[snip]

> >> If no one has any more objections within the next day, I'll pull in
> >> Maxime's v5 RGB to VGA bridge driver, and change the compatible to
> >> "dumb-vga-dac".
> > 
> > That works for me. You'll probably want to update the Kconfig and file
> > name to match though.
> 
> Queued to drm-misc, with the changes suggested by you and Laurent.

Those changes would have been worth a repost. I've had a look at the patch 
you've committed and it looks OK to me, so no harm done (the commit message is 
a bit inaccurate, but it's not the end of the world). Could you please make 
sure you repost patches in the future when you change them in non-trivial ways 
?

-- 
Regards,

Laurent Pinchart
