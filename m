From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 23 Jul 2013 01:52:55 -0300
Subject: linux-3.11-rc1: Internal error: Oops - undefined instruction: 0
 [#1] SMP ARM on OMAP3/AM335x
In-Reply-To: <51ECFBAC.7090900@ti.com>
References: <51ECFBAC.7090900@ti.com>
Message-ID: <CAOMZO5AAz+O=Xtajc8uojMniEkzvXk-kT6QAUtMXTnmiqbS63g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On Mon, Jul 22, 2013 at 6:30 AM, Roger Quadros <rogerq@ti.com> wrote:
> Hi,
>
> I observe the following problem on booting v3.11-rc1 on OMAP3 beagle board.
>
> [    5.888946] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> [    5.896057] Modules linked in:
> [    5.899322] CPU: 0 PID: 9 Comm: rcu_sched Not tainted 3.11.0-rc2-00001-g1ea701a #876
> [    5.907501] task: ce0720c0 ti: ce07a000 task.ti: ce07a000
> [    5.913208] PC is at check_and_switch_context+0x130/0x4dc
> [    5.918914] LR is at check_and_switch_context+0xd8/0x4dc

Got the same issue on a mx53 and prepared a fix. Will submit it shortly.

Regards,

Fabio Estevam
