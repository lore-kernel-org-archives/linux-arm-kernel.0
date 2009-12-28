From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 28 Dec 2009 14:55:41 +0900
Subject: [PATCH 0/5] V7/Cortex/omap34xx fixes for 2.6.33-rc1: DCC, kexec,
	atags
In-Reply-To: <20091219034151.26198.26570.stgit@localhost>
References: <20091219034151.26198.26570.stgit@localhost>
Message-ID: <aec7e5c30912272155s41ce8914hd03a5e4c740a5b9d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Sat, Dec 19, 2009 at 12:45 PM, Tony Lindgren <tony@atomide.com> wrote:
> Here are some v7 fixes, mostly to make kexec work.
>
> Using 2.6.33-rc1, these fixes, and kexec from kexec-tools
> git repo, I can reboot my n900 in a loop reliably.

Thanks for your work on this. I previously tested kexec on ARM V6 and
V7 and noticed that V7 didn't work. I revisited my V7 test after
becoming aware of your patches. The single patch below unbreaks V7 on
my target system.

> ? ? ?arm: Fix cpu_proc_fin() for proc-v7.S and make kexec work

Cheers,

/ magnus
