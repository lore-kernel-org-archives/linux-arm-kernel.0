From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 08 Mar 2013 17:06:42 -0800
Subject: [PATCH 03/10] ARM: smp_twd: Divorce smp_twd from local timer API
In-Reply-To: <20130308202947.GK11806@atomide.com>
References: <1362614646-24113-1-git-send-email-sboyd@codeaurora.org>
 <1362614646-24113-4-git-send-email-sboyd@codeaurora.org>
 <20130308004011.GD11806@atomide.com> <51393B59.3070200@codeaurora.org>
 <20130308180730.GE11806@atomide.com> <513A2B20.30805@codeaurora.org>
 <20130308194802.GG11806@atomide.com> <513A40EF.8050403@codeaurora.org>
 <20130308200811.GJ11806@atomide.com> <513A4774.3040605@codeaurora.org>
 <20130308202947.GK11806@atomide.com>
Message-ID: <513A8B22.5030008@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/13 12:29, Tony Lindgren wrote:
> Applying that does not seem to help, but you might want to get vexpress
> running anyways for some multiplatform sanity checks.
>
> I just built and installed qemu-linaro from their git, then ran the
> command above. Looks like stock qemu does not work for vexpress for some
> reason. You can probably use a dummy initrd and rootfs to debug this
> though :)

So my patchset didn't break qemu?

>
> More info on qemu-linaro at:
>
> https://launchpad.net/qemu-linaro

Thanks for the link.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
