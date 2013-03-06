From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Mar 2013 20:45:57 +0100
Subject: 3.9-rc1 regression in arm dtb build
In-Reply-To: <20130306193332.GA6022@amd.pavel.ucw.cz>
References: <20130306193332.GA6022@amd.pavel.ucw.cz>
Message-ID: <20130306204557.3ff80000@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Pavel Machek,

On Wed, 6 Mar 2013 20:33:32 +0100, Pavel Machek wrote:

> Moves dtb files from arch/arm/boot/ to arch/arm/boot/dtb. That causes
> several problems:
> 
> 1) it is inconsistent with 3.8, making switching between 3.9-rc1 and
> 3.8 tricky

The commit you're pointing to was part of 3.8, and so the dtb move to
arch/arm/boot/dts/ is already here since quite a bit of time. At least,
it's not something you introduced in 3.9-rc1.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
