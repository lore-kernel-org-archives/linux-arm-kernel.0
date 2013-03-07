From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 7 Mar 2013 21:28:54 +0100
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130307195541.GA20695@obsidianresearch.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <201303070337.43288.arnd@arndb.de> <20130307115817.3b3cad20@skate>
 <20130307173736.GA20840@obsidianresearch.com>
 <20130307201133.42a6c44b@skate>
 <20130307195541.GA20695@obsidianresearch.com>
Message-ID: <20130307212854.24be187f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Thu, 7 Mar 2013 12:55:41 -0700, Jason Gunthorpe wrote:

> > Adding description of windows in the Device Tree can be added later on,
> > in a completely DT backward compatible way, and the mvebu-devbus driver
> > can be adjusted accordingly.
> 
> Hmm.. You could make a new DT that is compatible with an older kernel,
> but once the mvebu_mbus_add_window is moved into the mbus driver it
> would require an updated DT.

So what is your proposal that preserves non-DT compatibility? As I
already said multiple times, we still have non-DT platforms around, and
we can leave them on the side on this topic, so we have to have a
solution that keeps non-DT compatibility for the moment.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
