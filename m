From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 6 May 2010 15:46:30 +0200
Subject: [PATCH 1/6] U6/U6715 ARM architecture files
In-Reply-To: <1272439976-24799-2-git-send-email-philippe.langlais@stericsson.com>
References: <1272439976-24799-1-git-send-email-philippe.langlais@stericsson.com>
	<1272439976-24799-2-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <20100506134630.GB1632@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> +config MACHINE_NAME
> +	prompt "Machine Name"
> +	depends on ARCH_U67XX
> +	default "STE_U67xx_refd"
> +	string
> +	help
> +		Change the machine name for application framework convenience
> +		It will be set in board_u6*.c file
> +

It would be better to avoid this.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
