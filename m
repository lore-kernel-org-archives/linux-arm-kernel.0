From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Tue, 21 Jun 2016 09:07:59 -0700
Subject: [PATCH 0/4] Get kexec working on SMP omap variants
In-Reply-To: <1466495565-17480-1-git-send-email-tony@atomide.com>
References: <1466495565-17480-1-git-send-email-tony@atomide.com>
Message-ID: <cfc75c15-ab10-22ee-35b8-529e28d2773c@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/21/2016 12:52 AM, Tony Lindgren wrote:
> Hi all,
>
> Here are some patches to make kexec work for SMP omaps. To test
> these you need to use the latest kexec-tools.git kexec with
> Russell's recent patches in "[PATCH 0/2] Simple fix to the ARM
> kexec tools implementation" thread fixed for 6x. Or else you
> need to use appended DTB.
>
> I've tested these so far on 4430 duovero, omap5-uevm, and
> beagle-x15.
>

>
>
> Tony Lindgren (4):
>   ARM: OMAP4+: Initialize SAR RAM base early for proper CPU1 reset for
>     kexec
>   ARM: OMAP4+: Prevent CPU1 related hang with kexec
>   ARM: OMAP4+: Reset CPU1 properly for kexec
>   ARM: OMAP4+: Allow kexec on SMP variants
>

I suggest to do bit wider testing including PM. From
quick scan, the series looks fine to me.

FWIW, Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
