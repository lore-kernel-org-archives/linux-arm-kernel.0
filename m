From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 27 May 2014 13:38:51 +0200
Subject: [PATCH 1/1] ARM: mvebu: Staticize mvebu_cpu_reset_init
In-Reply-To: <1401190107-21359-1-git-send-email-sachin.kamat@linaro.org>
References: <1401190107-21359-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20140527133851.2672f626@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sachin Kamat,

On Tue, 27 May 2014 16:58:27 +0530, Sachin Kamat wrote:
> 'mvebu_cpu_reset_init' is local to this file.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  arch/arm/mach-mvebu/cpu-reset.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
