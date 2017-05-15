From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 15 May 2017 11:50:11 +0200
Subject: [PATCH 1/2] ARM: at91/defconfig: make system tickless when idle
In-Reply-To: <20170505084343.10417-1-quentin.schulz@free-electrons.com>
References: <20170505084343.10417-1-quentin.schulz@free-electrons.com>
Message-ID: <20170515095011.sitvgxidoiyrjrxf@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2017 at 10:43:42 +0200, Quentin Schulz wrote:
> This makes Atmel sama5 platforms' system tickless when idle.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  arch/arm/configs/sama5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

I've applied both after fixing the subjet but I think it would make
sense to do the same in at91_dt_defconfig. Can you test?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
