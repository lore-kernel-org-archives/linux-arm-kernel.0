From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 26 Jan 2015 13:38:22 +0800
Subject: [PATCH -tip/urgent  0/2]kprobes bugfixes around optprobe
In-Reply-To: <20150123064217.30731.49156.stgit@localhost.localdomain>
References: <20150123064217.30731.49156.stgit@localhost.localdomain>
Message-ID: <54C5D2CE.5030402@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ingo,

Is there any problem on these patches? I'm unable to find them in upstream kernel
and -tip repository.

Thank you.

On 2015/1/23 14:42, Masami Hiramatsu wrote:
> Hi Ingo,
> 
> Here are two patches for fixing bugs in kprobes, related to
> optprobe and enable/disable kprobe knob.
> 
> These are reported and fixed by Wang Nan.
> https://lkml.org/lkml/2015/1/5/270
> https://lkml.org/lkml/2015/1/19/680
> 
> Thank you,
> 
> 
> ---
> 
> Wang Nan (2):
>       [BUGFIX]kprobes: set kprobes_all_disarmed earlier to enable re-optimization.
>       [BUGFIX]kprobes: makes kprobes/enabled works correctly for optimized kprobes.
> 
> 
>  kernel/kprobes.c |   18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> --
> Masami HIRAMATSU
> Software Platform Research Dpt. Linux Technology Center
> Hitachi, Ltd., Yokohama Research Laboratory
> E-mail: masami.hiramatsu.pt at hitachi.com
> 
