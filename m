From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Jun 2013 12:44:38 +0300
Subject: [PATCH v7 5/9] ARM: OMAP: USB: Add phy binding information
In-Reply-To: <1371113039-5784-6-git-send-email-kishon@ti.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-6-git-send-email-kishon@ti.com>
Message-ID: <20130618094438.GT5461@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 02:13:55PM +0530, Kishon Vijay Abraham I wrote:
> In order for controllers to get PHY in case of non dt boot, the phy
> binding information (phy device name) should be added in the platform
> data of the controller.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

I would rather not pass strings around, any other way to handle this ?
Why do you need to pass this string ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/34bb6cf0/attachment-0001.sig>
