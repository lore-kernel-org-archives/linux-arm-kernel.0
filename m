From: edubezval@gmail.com (Eduardo Valentin)
Date: Thu, 17 Nov 2016 06:53:28 -0800
Subject: [PATCH 0/3] thermal: Fix module autoload for drivers
In-Reply-To: <CABxcv==keE6X5B1R+DSaZewVDdpCtuGF5j4S46YF3pncHT8q2Q@mail.gmail.com>
References: <1476455702-21748-1-git-send-email-javier@osg.samsung.com>
 <CABxcv==keE6X5B1R+DSaZewVDdpCtuGF5j4S46YF3pncHT8q2Q@mail.gmail.com>
Message-ID: <20161117145327.GA2781@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 08:50:11AM -0300, Javier Martinez Canillas wrote:
> Hello Eduardo,
> 
> On Fri, Oct 14, 2016 at 11:34 AM, Javier Martinez Canillas
> <javier@osg.samsung.com> wrote:
> > Hello,
> >
> > This small series contains trivial fixes to allow modules to be autoloaded
> > when its correspoinding thermal device is registered.
> >
> > Best regards,
> > Javier
> >
> >
> > Javier Martinez Canillas (3):
> >   thermal: max77620: Fix module autoload
> >   thermal: tango: Fix module autoload
> >   thermal: db8500: Fix module autoload
> >
> 
> Any comments about these patches?

So far no. I am finalizing a couple of automated testing, but they are
in my queue.

Thanks for the fixes.

BR,

> 
> Best regards,
> Javier
