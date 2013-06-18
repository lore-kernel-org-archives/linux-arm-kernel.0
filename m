From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Jun 2013 12:43:00 +0300
Subject: [PATCH v7 4/9] usb: phy: twl4030: twl4030 shouldn't be
 subsys_initcall
In-Reply-To: <1371113039-5784-5-git-send-email-kishon@ti.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-5-git-send-email-kishon@ti.com>
Message-ID: <20130618094300.GS5461@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 02:13:54PM +0530, Kishon Vijay Abraham I wrote:
> Changed the inticall from subsys_initcall to module_init for
> twl4030-usb.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

not part of the series, should be sent separately. I'll queue this one
for v3.12 once v3.11-rc1 is tagged.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/2a18c565/attachment.sig>
