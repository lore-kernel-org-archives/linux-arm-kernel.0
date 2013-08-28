From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 28 Aug 2013 16:48:29 +0200
Subject: [PATCH 0/2] ARM: Dove: Add audio to the DT
In-Reply-To: <20130828113438.0a77fd54@armhf>
References: <20130828113438.0a77fd54@armhf>
Message-ID: <20130828164829.14256ce2@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jean-Francois Moine,

On Wed, 28 Aug 2013 11:34:38 +0200, Jean-Francois Moine wrote:
> This patch series adds audio DT to the Dove boards and activates the
> Cubox audio device.
> 
> Full audio in the Cubox will work when the DT extension of the generic
> simple audio card will be complete.

What is the status of this generic simple audio card effort? I've seen
the patch you had posted at https://lkml.org/lkml/2013/7/20/128 and the
following discussion. Has anyone picked up the work of Kuninori
Morimoto?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
