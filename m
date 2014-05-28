From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 29 May 2014 01:19:43 +0200
Subject: [PATCH] misc: atmel_pwm: only build for supported platforms
In-Reply-To: <20140528184217.GB30031@kroah.com>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-17-git-send-email-arnd@arndb.de>
 <536CA80A.60201@atmel.com> <1401279867.22486.6.camel@x220>
 <20140528155916.GA9793@piout.net> <1401293383.22486.18.camel@x220>
 <20140528175439.GA18470@piout.net> <1401299948.22486.51.camel@x220>
 <20140528184217.GB30031@kroah.com>
Message-ID: <20140528231940.GC18470@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/05/2014 at 11:42:17 -0700, Greg Kroah-Hartman wrote :
> On Wed, May 28, 2014 at 07:59:08PM +0200, Paul Bolle wrote:
> > So the patch we're discussing here will never be included in a release?
> 

As it hit linux-next, I guess it will be in 3.16

> So, should I just remove it right now?  I like deleting files :)
> 

I also like doing that, let me resend my series, rebased on linux-next
because of the dependency on the PWM tree. Then I will let you and
Nicolas decide what you want to do with it.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
