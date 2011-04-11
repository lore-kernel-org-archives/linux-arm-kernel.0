From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 11 Apr 2011 22:02:41 +0300
Subject: i.MX31 Early Kernel Messages
In-Reply-To: <352399F8DB39E14FBB4B648897CA32E60825A82A@DE08EV802.global.ds.honeywell.com>
References: <352399F8DB39E14FBB4B648897CA32E60825A82A@DE08EV802.global.ds.honeywell.com>
Message-ID: <20110411190241.GB18740@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Mon, Apr 11, 2011 at 02:48:36PM -0400, Russell, Richard S (G&N CoE) wrote:
> As best I can tell, the TimeSys kernel sets up an early console to
> display the early kernel messages. Is there an equivalent feature in the
> latest kernel?  If so, how does one enable it?

Enable the early printk option in you kernel configuration (Kernel hacking -> 
Kernel low-level debugging functions -> Early printk), and add 'earlyprintk' 
to your kernel command line parameters.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
