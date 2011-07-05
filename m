From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 5 Jul 2011 12:18:58 +0200
Subject: [PATCH 2/3] at91-ohci: support overcurrent notification
In-Reply-To: <4E12E3A6.3040902@parrot.com>
References: <1309856728-8265-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1309856728-8265-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<4E12E3A6.3040902@parrot.com>
Message-ID: <20110705121858.411b183e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le Tue, 5 Jul 2011 12:12:54 +0200,
Matthieu CASTET <matthieu.castet@parrot.com> a ?crit :

> Why don't you forward the overcurrent notification to the usb stack ?
> A printk is quite useless.

Do you have a pointer to the appropriate functions/mechanisms of the
USB stack about this ?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
