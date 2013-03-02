From: anton@enomsg.org (Anton Vorontsov)
Date: Sat, 2 Mar 2013 15:33:35 -0800
Subject: [PATCH 00/40] Power: AB8500: Internal development push
In-Reply-To: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
References: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20130302233335.GA25293@lizard.sbx05280.losalca.wayport.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lee,

On Fri, Feb 15, 2013 at 12:44:30PM +0000, Lee Jones wrote:
> This is the 3rd and final instalment of the push to synchronise
> the ABx500 Battery Management series of internal development patches
> due for Mainline.
> 
> This patch-set submission is for reviewing purposes only. Please
> don't apply patches directly from this patch-set, as there are some
> interdependencies with another patch-set due for the MFD tree. We
> can chat about how to over-come this at a later date.

It looks so much better than the initial series! Frankly, I couldn't find
anything utterly wrong with it. :-)  (I did notice a couple of cosmetic
issues, but considering the amount of work and patches needed rebasing, it
would be insane of me to ask fixing these. :-)

So, I can easily merge it, as long as MFD part is either Acked or handled
somehow else. But I do want to merge the drivers/power/ part via battery
tree -- the part is quite large and thus prone to conflicts if someone
asks me to merge a patch that would touch the same lines.

Thanks so much!

Anton
