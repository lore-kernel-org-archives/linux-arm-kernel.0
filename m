From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 11 Mar 2015 19:33:43 +0100
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid
 crash on armada-xp
In-Reply-To: <55008483.8050603@list.ru>
References: <54FF21BE.2040506@list.ru>
 <20150311175227.499612af@free-electrons.com>
 <55007ADD.6080505@list.ru>
 <20150311174618.GE8656@n2100.arm.linux.org.uk>
 <55008483.8050603@list.ru>
Message-ID: <20150311193343.0317e3e1@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stas Sergeev,

On Wed, 11 Mar 2015 21:08:03 +0300, Stas Sergeev wrote:

> mem=0xc0000000 seems to work!
> 0xd0000000 or 0xe0000000 do not.
> OK, so 3Gb instead of 8... but at least it boots! :)

What is the value of the register 0xf1020254 ?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
