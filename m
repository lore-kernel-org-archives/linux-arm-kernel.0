From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 2 Jan 2018 14:06:36 +0100
Subject: misc: bh1770glc: move sysfs interace to Documentation/ABI
In-Reply-To: <20171226092957.GA3817@mordor.localdomain>
References: <20171226092957.GA3817@mordor.localdomain>
Message-ID: <20180102130636.GA20209@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> In Documentation/misc-devices/bh1770glc.txt, there is a description of the sysfs
> interface which could be moved to Documentation/ABI.
> 
> Would such a change be useful?

Not at the moment.

> The ABI documentation format looks like the following:
> 
> What:          (the full sysfs path of the attribute)
> Date:          (date of creation)
> KernelVersion: (kernel version it first showed up in)
> Contact:       (primary contact)
> Description:   (long description on usage)
> 
> I am doing this in an exercise to move sysfs ABI interfaces (which are
> documented) to their right place i.e. in Documentation/ABI along with the rest.

The interface should probably be changed to iio one, to be consistent
with other sensors such as Apds990x.

If you have the hardware, help would be welcome.

  	      	       	     	   	   		     	   	Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180102/20ffcbb1/attachment-0001.sig>
