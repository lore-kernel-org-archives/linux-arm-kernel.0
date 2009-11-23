From: a.zummo@towertech.it (Alessandro Zummo)
Date: Mon, 23 Nov 2009 09:21:41 +0100
Subject: [rtc-linux] [PATCH] ARM: NUC900: add rtc controller driver
	support  for NUC900
In-Reply-To: <4B0A2D31.5020307@gmail.com>
References: <4B097FA0.8040308@gmail.com>
	<20091122214107.1a0c4e72@linux.lan.towertech.it>
	<4B0A2D31.5020307@gmail.com>
Message-ID: <20091123092141.519d0ec1@linux.lan.towertech.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Nov 2009 14:35:29 +0800
Wan ZongShun <mcuos.com@gmail.com> wrote:

> Thanks a lot for your advice, and I have fixed my patch.
> But, I have a question ,which is that why do not implement ops->ioctl()
> unless absolutely necessary? and I see many other rtc driver have implemented it. 

 That's because the RTC framework will provide one
 for you if you define the irq functions in your 
 rtc_ops. check *_irq_enable, irq_set_state, irq_set_freq.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
