From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 14 Mar 2015 13:44:28 +0100
Subject: [PATCH v3 0/5] KVM ARM64 Migration Fixes
In-Reply-To: <1426266176-14933-1-git-send-email-alex.bennee@linaro.org>
References: <1426266176-14933-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150314124428.GA10935@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex and Marc,

On Fri, Mar 13, 2015 at 05:02:51PM +0000, Alex Benn?e wrote:
> Some fairly minor updates from the last series I sent out:
> 
>   - Re-based on v4.0-rc3
>   - Use KVM_MP_STATE_STOPPED instead of KVM_MP_STATE_HALTED
>   - Some minor textual tidy ups on commit msgs and comments
>   - Move the re-factored vgic_queue_irq_to_lr to before the active changes
> 
> The branch I've been working with can be found at:
> 
>   http://git.linaro.org/people/alex.bennee/linux.git
>   branch: migration/kvmarm-fixes-for-4.0-v3
> 

These look good to me.

Marc, unless you have objections, I'll go ahead and take patch 5 as a
fix and get that in for the next -rc, and will queue the rest?  This
will conflict, but we can fix it up with the linux-next merge.


-Christoffer
