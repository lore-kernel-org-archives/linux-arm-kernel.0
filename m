From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 28 Jan 2013 11:46:21 +0000
Subject: OMAP baseline test results for v3.8-rc5
In-Reply-To: <20130128113818.GD28698@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1301260838300.19277@utopia.booyaka.com>
 <20130126084604.GB8754@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EA9456A@DBDE01.ent.ti.com>
 <20130128113818.GD28698@arwen.pp.htv.fi>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA946E4@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Mon, Jan 28, 2013 at 17:08:19, Balbi, Felipe wrote:

> seems to be a bug with __unflatten_device_tree()...

> U-Boot# bootm 0x80200000 - 0x80f80000

Try loading dtb at a different address, I do,

bootm 81000000 - 82000000

Regards
Afzal
