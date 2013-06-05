From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 5 Jun 2013 17:11:52 +0530
Subject: [PATCH v2 5/5] ARM: davinci: serial: platform code cleanup
In-Reply-To: <1369729686-6595-6-git-send-email-prakash.pm@ti.com>
References: <1369729686-6595-1-git-send-email-prakash.pm@ti.com>
 <1369729686-6595-6-git-send-email-prakash.pm@ti.com>
Message-ID: <51AF2400.3020906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 5/28/2013 1:58 PM, Manjunathappa, Prakash wrote:
> 1) "struct davinci_uart_config" is introduced to specify
>    UART ports brought out or enabled on the board. But
>    none of the boards use them for that purpose, so clean
>    it up.
> 2) Have pointer to platform device as a argument for
>    davinci_serial_init(), no need of serial_dev in
>    struct soc_info now.
> 3) No need of davinci_serial_setup_clk(), not called from
>    multiple places, hence reduce function call overhead.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> Suggested-by: Sekhar Nori <nsekhar@ti.com>

We generally clean up code before undertaking modifications. Is there a
reason why this cannot be done first-up?

Thanks,
Sekhar
