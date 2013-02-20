From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Feb 2013 09:53:14 +0000
Subject: randconfig errors
In-Reply-To: <20130220063635.GE23302@intel.com>
References: <511E6FA4.2000709@gmail.com> <201302152012.04128.arnd@arndb.de>
 <20130220063635.GE23302@intel.com>
Message-ID: <201302200953.14584.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 February 2013, Vinod Koul wrote:
> > It really should have been in the crypto tree before Mark's patches
> > to use them, but if Chris is still considering the the hsmmc dt
> > patches for 3.9, including them there is probably the best way forward.
> > 
> > I would expect him to say no them at this point though, and in that
> > case, I think it should be either the slave-dma tree or the arm-soc
> > tree.
> Do you want me to add the compat() patch? I had acked it sometime back
> 
> I was hoping to send the PULL request in a day or two... Pls let me know...

The patch is clearly needed in 3.9, so one of us should add it. It feels
more appropriate for you to do it since it only touches the dma-slave
header files. If you don't want to add more late patches to your branch,
I can also put it into the arm-soc fixes queue, you decide.

	Arnd
