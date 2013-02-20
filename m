From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Feb 2013 17:42:58 +0200
Subject: [PATCH 7/8] ARM: OMAP: hwmod: extract module address space from
 DT blob
In-Reply-To: <1361374735-22018-8-git-send-email-santosh.shilimkar@ti.com>
References: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
 <1361374735-22018-8-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20130220154258.GI16652@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 20, 2013 at 09:08:54PM +0530, Santosh Shilimkar wrote:
> Patch adds the code for extracting the module ocp address space from device
> tree blob in case the hwmod address space look up fails.

IMHO you should lookup on DT first and if that fails try hwmod ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130220/716cae75/attachment.sig>
