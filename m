From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 28 Aug 2013 12:21:46 +0200
Subject: [PATCH 04/19] ARM: set BE8 if LE in head code
In-Reply-To: <1377639509-22778-5-git-send-email-ben.dooks@codethink.co.uk>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
 <1377639509-22778-5-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130828122146.4e30722a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Tue, 27 Aug 2013 22:38:14 +0100, Ben Dooks wrote:
> If we are booting in LE and compiled for BE8, then add code to
> set the state to bE8. Since the instruction stream is always LE,
> we do not need to do anything special to the instruction.
> 
> Also ensure that the secondary processors are started in the same mode.
> 
> Note, we do add about 20 bytes to the kernel image, but it seems easier
> to do this than adding another configuration to change.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Conflicts:
> 	arch/arm/kernel/sleep.S

Those two lines probably shouldn't be there.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
