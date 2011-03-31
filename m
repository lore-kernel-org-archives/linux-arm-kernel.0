From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 31 Mar 2011 12:49:05 +0300
Subject: [PATCH 5/7] add GPMI support for imx28
In-Reply-To: <1300240521-4344-6-git-send-email-b32955@freescale.com>
References: <1300240521-4344-1-git-send-email-b32955@freescale.com>
	<1300240521-4344-6-git-send-email-b32955@freescale.com>
Message-ID: <1301564945.2828.27.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-16 at 09:55 +0800, Huang Shijie wrote:
> +       pio[0] =
> +               BF_GPMI_CTRL0_COMMAND_MODE(command_mode)        |
> +               BM_GPMI_CTRL0_WORD_LENGTH                       |
> +               BF_GPMI_CTRL0_CS(mil->current_chip)             |
> +               BF_GPMI_CTRL0_ADDRESS(address)                  |
> +               BF_GPMI_CTRL0_XFER_COUNT(mil->upper_len); 

Strange way to format the code ...

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
