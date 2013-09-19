From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 19 Sep 2013 14:34:00 +0100
Subject: [PATCH 25/26] ARM: vexpress: remove custom .init_time hook
In-Reply-To: <1379526839-14798-26-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-26-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1379597640.3347.18.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-09-18 at 18:53 +0100, Sebastian Hesselbarth wrote:
> With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> remove custom .init_time hooks. The call to versatile_sched_clock_init
> is moved to .init_early instead, were it is also for non-DT boards.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Tested-by: Jon Medhurst (Tixy) <tixy@linaro.org>

Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks!

Pawel
