From: aishpant@gmail.com (Aishwarya Pant)
Date: Tue, 2 Jan 2018 22:55:16 +0530
Subject: misc: bh1770glc: move sysfs interace to Documentation/ABI
In-Reply-To: <20180102130636.GA20209@amd>
References: <20171226092957.GA3817@mordor.localdomain>
 <20180102130636.GA20209@amd>
Message-ID: <20180102172516.vfc4uf43mappt3um@mordor.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 02, 2018 at 02:06:36PM +0100, Pavel Machek wrote:
> Hi!
> 
> > In Documentation/misc-devices/bh1770glc.txt, there is a description of the sysfs
> > interface which could be moved to Documentation/ABI.
> > 
> > Would such a change be useful?
> 
> Not at the moment.
> 
> > The ABI documentation format looks like the following:
> > 
> > What:          (the full sysfs path of the attribute)
> > Date:          (date of creation)
> > KernelVersion: (kernel version it first showed up in)
> > Contact:       (primary contact)
> > Description:   (long description on usage)
> > 
> > I am doing this in an exercise to move sysfs ABI interfaces (which are
> > documented) to their right place i.e. in Documentation/ABI along with the rest.
> 
> The interface should probably be changed to iio one, to be consistent
> with other sensors such as Apds990x.
> 
> If you have the hardware, help would be welcome.

Yes, makes sense for this driver to be with the iio light sensors. I don't have
the hardware for it. So, I won't move the sysfs interface to ABI.

Aishwarya

> 
>   	      	       	     	   	   		     	   	Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
