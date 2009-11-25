From: a.zummo@towertech.it (Alessandro Zummo)
Date: Wed, 25 Nov 2009 14:36:34 +0100
Subject: [rtc-linux] Re: [PATCH V3] ARM: NUC900: add RTC driver support
	for  nuc910 and nuc920
In-Reply-To: <713d0d430911250451x51e0196bwdcbe5e8f087c3f8c@mail.gmail.com>
References: <4B0D1FFB.5060403@gmail.com>
	<713d0d430911250451x51e0196bwdcbe5e8f087c3f8c@mail.gmail.com>
Message-ID: <20091125143634.1b8e0839@linux.lan.towertech.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Nov 2009 20:51:24 +0800
Hu Ruihuan <specter118@gmail.com> wrote:

> I think you should lock irq before the serial read and write to the
> REG_RTC_RIER register.

 the lock seems not used anymore. the rtc framework has some locking
 of his own, driver authors are suggested to check if it's enough.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
