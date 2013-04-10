From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Wed, 10 Apr 2013 14:04:30 +0100
Subject: [PATCH] ARM: hw_breakpoint: Do not use __cpuinitdata for
 dbg_cpu_pm_nb
In-Reply-To: <20130410125316.GC26992@mudshark.cambridge.arm.com>
References: <1365588278-5185-1-git-send-email-hechtb+renesas@gmail.com>
 <20130410111148.GA26992@mudshark.cambridge.arm.com>
 <CABYn4szw=kE_DD1eNZ-CsM__o_cJUA5+F4M8T5-Uyf_nw+bfGg@mail.gmail.com>
 <5165554D.3040107@arm.com>
 <CABYn4szX3k2m-BZRTH3xKGChHGu212cHnEAoYakbctHOia+ibA@mail.gmail.com>
 <20130410125316.GC26992@mudshark.cambridge.arm.com>
Message-ID: <5165635E.50804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/13 13:53, Will Deacon wrote:
> On Wed, Apr 10, 2013 at 01:11:16PM +0100, Bastian Hecht wrote:
>>> Will, we have the same issue in arch/arm/kernel/perf_event_cpu.c.
>>> Lorenzo is currently working on an appropriate patch.
>
> I don't think we do. The __cpuinitdata annotation there is only used on a
> hotplug notifier, which should be fine.

You right, I got confused about what is already upstream.

-- Dietmar

>
> Will
>

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
