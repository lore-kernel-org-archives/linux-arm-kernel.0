From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Jul 2013 05:27:44 -0700
Subject: Boot hang regression 3.10.0-rc4 -> 3.10.0
In-Reply-To: <20130710121037.GS5523@atomide.com>
References: <20130705115959.GQ5523@atomide.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com> <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com> <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi>
 <87mwpuakod.fsf@linaro.org> <20130710121037.GS5523@atomide.com>
Message-ID: <20130710122744.GU5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [130710 05:17]:
> * Kevin Hilman <khilman@linaro.org> [130710 01:29]:
> 
> If the problem is omap-serial.c idling things while earlycon is
> running, then omap-serial.c should be fixed.

If this is the case, then delaying the idling in omap-serial.c
should take care of the issue as earlycon gets disabled when
the real console has been initialized.

Regards,

Tony
