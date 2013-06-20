From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 20 Jun 2013 01:00:07 -0700
Subject: [PATCH 0/2] clk vexpress updates for 3.11
In-Reply-To: <1370876707-25265-1-git-send-email-pawel.moll@arm.com>
References: <1370876707-25265-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20130620080007.9136.12423@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Pawel Moll (2013-06-10 08:05:05)
> Hi Mike,
> 
> Could you please queue these two small updates of the vexpress clk
> drivers?

Taken into clk-next for 3.11.

Regards,
Mike

> 
> Thanks!
> 
> Pawel
> 
> Pawel Moll (2):
>   clk: vexpress: Use full node name to identify individual clocks
>   clk: vexpress: Make the clock drivers directly available for arm64
> 
>  drivers/clk/Kconfig                      | 2 +-
>  drivers/clk/versatile/clk-vexpress-osc.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> -- 
> 1.8.1.2
