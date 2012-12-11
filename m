From: csd@broadcom.com (Christian Daudt)
Date: Tue, 11 Dec 2012 11:13:33 -0800
Subject: [PATCH V3] ARM: bcm281xx: Add timer driver
In-Reply-To: <50C78330.7040605@wwwdotorg.org>
References: <1355250387-622-1-git-send-email-csd@broadcom.com>
 <50C78330.7040605@wwwdotorg.org>
Message-ID: <50C785DD.8030407@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-12-11 11:02 AM, Stephen Warren wrote:
> On 12/11/2012 11:26 AM, Christian Daudt wrote:
>> This adds support for the Broadcom timer, used in the following SoCs:
>> BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
> Reviewed-by: Stephen Warren<swarren@nvidia.com>
>
Thanks.

>> This patch needs the arm-soc/soc/next branch
> Only if it goes into 3.8, which I assume it won't?
>
Ok, I wasn't clear on that. I meant that this patch only applies on top 
of arm-soc/soc/next as it needs the mach-bcm patch which is sitting only 
there at the moment. I'm fine with having this in 3.8 as this patch only 
affects the above SoCs. But I'll leave that to Olof and Arnd.
> For 3.9, you'll need to rebase it on top of my struct sys_timer removal
> series, which I hope to put into linux-next ASAP after 3.8-rc1 comes out.
>
Is there a git repo where I can look into this right now ? If so I can 
already look at what diffs will be required for this.

  Thanks,
    csd
