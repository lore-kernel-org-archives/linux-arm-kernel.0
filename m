From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Mar 2013 17:55:41 +0100
Subject: mvebu: Device bus driver resurrection
In-Reply-To: <20130326164505.GB30255@obsidianresearch.com>
References: <20130326124337.GD2454@localhost>
 <20130326164505.GB30255@obsidianresearch.com>
Message-ID: <20130326175541.3aae36af@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Tue, 26 Mar 2013 10:45:05 -0600, Jason Gunthorpe wrote:

> >   * The address decoding windows should *not* be setup by this driver,
> >     but rather be described in the device tree itself.
> 
> I'm going to suggest you send out a quick DT sample for what you are
> thinking, that might save lots of effort?

As far as the mvebu-mbus DT binding is concerned, yes, my plan is to
start a new thread to discuss the DT binding, and get the DT
representation sorted out before doing the necessary changes at the
driver level and therefore save lots of effort, as you suggest.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
