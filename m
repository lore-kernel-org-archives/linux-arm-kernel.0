From: a.zummo@towertech.it (Alessandro Zummo)
Date: Tue, 3 Aug 2010 02:03:28 +0200
Subject: [PATCH] PXA: Fix wakealarm capability for pxa-rtc
In-Reply-To: <201008011738.16225.marek.vasut@gmail.com>
References: <1280550147-12380-1-git-send-email-marek.vasut@gmail.com>
	<201008010253.28319.marek.vasut@gmail.com> <87eieiziri.fsf@free.fr>
	<201008011738.16225.marek.vasut@gmail.com>
Message-ID: <20100803020328.1046308a@linux.lan.towertech.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 1 Aug 2010 17:38:16 +0200
Marek Vasut <marek.vasut@gmail.com> wrote:

> > As I see now your real
> > problem, I would request you leave the existing "device_init_wakeup(x, 1)"
> > *and* you add yours to make the class driver happy.  
> 
> Why wouldn't the driver wake up from suspend?
> > 

 may I see the latest version of your patch, Marek?

 ty

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
