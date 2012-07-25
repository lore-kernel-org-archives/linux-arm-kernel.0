From: balbi@ti.com (Felipe Balbi)
Date: Wed, 25 Jul 2012 14:07:15 +0300
Subject: [PATCH v4 2/4] mfd: omap: control: core system control driver
In-Reply-To: <500FD2EC.7060208@dev.rtsoft.ru>
References: <500FD2EC.7060208@dev.rtsoft.ru>
Message-ID: <20120725110714.GF16794@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 25, 2012 at 03:05:16PM +0400, Konstantin Baydarov wrote:
> This patch introduces a MFD core device driver for
> OMAP system control module.
> 
> The control module allows software control of
> various static modes supported by the device. It is
> composed of two control submodules: general control
> module and device (padconfiguration) control
> module.
> 
> Device driver is probed with postcore_initcall.
> Control module register CONTROL_STATUS that is needed
> by omap_type() is early mapped by postcore_initcall_sync.
> 
> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>

I believe this and the next 3 were authored by Eduardo. Also missing his
>From tag.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120725/ee160db6/attachment.sig>
