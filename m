From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 18 Jan 2015 13:02:38 +0100
Subject: [PATCH] bluetooth: Add hci_h4p driver
In-Reply-To: <20141223130219.GA5731@amd>
References: <20141223130219.GA5731@amd>
Message-ID: <20150118120238.GA16357@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Add HCI driver for H4 with Nokia extensions. This device is used on
> Nokia N900 cell phone.
> 
> Older version of this driver lived in staging, before being reverted
> in a4102f90e87cfaa3fdbed6fdf469b23f0eeb4bfd .

Any news here? I'd like the driver to hit 3.20...

								Pavel


>  Kconfig      |   10 
>  Makefile     |    4 
>  nokia_core.c | 1149 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  nokia_fw.c   |   99 +++++
>  nokia_h4p.h  |  214 ++++++++++
>  nokia_uart.c |  171 ++++++++
>  7 files changed, 1667 insertions(+)

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
