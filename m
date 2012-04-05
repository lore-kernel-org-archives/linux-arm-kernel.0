From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 05 Apr 2012 23:07:36 +0100
Subject: [PATCH 4/7 v4] ARM: kirkwood: add dreamplug (fdt) support.
In-Reply-To: <0032addd7e94c5d4d1a3a0be77fe79bcffee53db.1331601448.git.jason@lakedaemon.net>
References: <cover.1331601448.git.jason@lakedaemon.net>
 <0032addd7e94c5d4d1a3a0be77fe79bcffee53db.1331601448.git.jason@lakedaemon.net>
Message-ID: <1333663656.12209.62.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-03-13 at 01:57 +0000, Jason Cooper wrote:
> +DT_MACHINE_START(KIRKWOOD_DT, "Marvell Kirkwood (Flattened Device Tree)") 

This ends up as Machine: in /proc/cpuinfo, which seems to be normal?

Would it be worth trying to dynamically modify the machine string based
on the actual hardware the kernel is running on?

Ian.
-- 
Ian Campbell


Genius is ten percent inspiration and fifty percent capital gains.
