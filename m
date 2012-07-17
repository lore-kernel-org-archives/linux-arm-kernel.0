From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 17 Jul 2012 14:29:26 +0200
Subject: Device tree.
In-Reply-To: <500556CF.6030704@codethink.co.uk>
References: <500552C9.4090107@codethink.co.uk> <20120717140100.7c0ae90c@skate>
 <500556CF.6030704@codethink.co.uk>
Message-ID: <20120717142926.05c0c17f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 17 Jul 2012 13:13:03 +0100,
Ian Molton <ian.molton@codethink.co.uk> a ?crit :

> Unless I'm misunderstanding it, thats not quite what I need -
> although I should probably have made my hack depend on it.
> 
> I'm using a uImage; The prepending needs to happen to the zImage /
> Image.

What I typically do is generate a zImage, do the appending, and then
generate the uImage manually with mkimage. But I agree it could be
useful to have a 'make uImage.myboard' target which would happen the
myboard.dtb before preparing the uImage.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
