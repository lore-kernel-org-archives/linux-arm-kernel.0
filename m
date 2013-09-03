From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 3 Sep 2013 17:29:38 +0200
Subject: [PULL REQUEST] big-endian updates for ARM
In-Reply-To: <5225FE66.9070205@codethink.co.uk>
References: <20130903101332.GA26613@localhost.localdomain>
 <5225C714.3090504@codethink.co.uk> <20130903134546.5240306b@skate>
 <5225DB5C.1070903@codethink.co.uk> <20130903145529.631ae5cb@skate>
 <5225FE66.9070205@codethink.co.uk>
Message-ID: <20130903172938.1244acc9@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Tue, 03 Sep 2013 16:21:10 +0100, Ben Dooks wrote:

> Out of interest, should all patches in the series have the
> Tested-by line added to them, or just the top-level pull request?

I believe the Tested-by normall goes to the individual patches.
However, my testing on Armada XP obviously didn't exercise all the
patches (I haven't tested modules, I haven't used the bpf_jit thing, I
haven't tested the twd, smp_scu and pl01x fixes, etc.).

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
