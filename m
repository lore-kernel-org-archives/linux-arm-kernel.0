From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 25 Jun 2014 17:00:02 +0200
Subject: [PATCH v2 1/5] ARM: berlin: add SMP support
In-Reply-To: <1401897826-11711-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1401897826-11711-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401897826-11711-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <53AAE3F2.9060809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2014 06:03 PM, Antoine T?nart wrote:
> Adds SMP support for Berlin SoCs. Secondary CPUs are reset, then
> execute the instruction we put in the reset exception register, setting
> the pc at the address contained in the software reset address register,
> which is the physical address of the Berlin secondary startup.
>
> This implementation avoid using the pen lock mechanism.
>
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>

Applied to berlin/soc with Andrew's Reviewed-by.

Thanks!
