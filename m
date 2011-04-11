From: Richard.Russell@Honeywell.com (Russell, Richard S (G&N CoE))
Date: Mon, 11 Apr 2011 19:11:51 -0400
Subject: i.MX31 Early Kernel Messages
In-Reply-To: <20110411190241.GB18740@tarshish>
References: <352399F8DB39E14FBB4B648897CA32E60825A82A@DE08EV802.global.ds.honeywell.com>
	<20110411190241.GB18740@tarshish>
Message-ID: <352399F8DB39E14FBB4B648897CA32E60825AC4D@DE08EV802.global.ds.honeywell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Baruch!  That did the trick.

Richard


-----Original Message-----
From: Baruch Siach [mailto:baruch at tkos.co.il] 
Sent: Monday, April 11, 2011 2:03 PM
To: Russell, Richard S (G&N CoE)
Cc: linux-arm-kernel at lists.infradead.org
Subject: Re: i.MX31 Early Kernel Messages

Hi Richard,

On Mon, Apr 11, 2011 at 02:48:36PM -0400, Russell, Richard S (G&N CoE)
wrote:
> As best I can tell, the TimeSys kernel sets up an early console to
> display the early kernel messages. Is there an equivalent feature in
the
> latest kernel?  If so, how does one enable it?

Enable the early printk option in you kernel configuration (Kernel
hacking -> 
Kernel low-level debugging functions -> Early printk), and add
'earlyprintk' 
to your kernel command line parameters.

baruch

-- 
                                                     ~. .~   Tk Open
Systems
=}------------------------------------------------ooO--U--Ooo-----------
-{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
