From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 2 Jul 2012 11:19:47 +0200
Subject: [PATCH v5] arm: Add basic support for new Marvell Armada 370
 and Armada XP SoC
In-Reply-To: <4FF16797.8070405@codethink.co.uk>
References: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
 <4FEB2CC3.7090305@codethink.co.uk> <20120702103016.28b2637e@skate>
 <4FF16797.8070405@codethink.co.uk>
Message-ID: <20120702111947.2ce2b3cc@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Mon, 02 Jul 2012 10:19:19 +0100,
Ben Dooks <ben.dooks@codethink.co.uk> a ?crit :

> > Can you share the device tree you're using for your Cogent platform?

Thanks. Please add some memory to your system:

        memory { device_type = "memory"; reg = <0 0>; };

This definitely cannot work.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
