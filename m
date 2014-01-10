From: balbi@ti.com (Felipe Balbi)
Date: Fri, 10 Jan 2014 10:14:22 -0600
Subject: [PATCH 1/2] ARM: DRA7XX/AM43XX: randconfig fixes
In-Reply-To: <1389347850-22435-2-git-send-email-t-kristo@ti.com>
References: <1389347850-22435-1-git-send-email-t-kristo@ti.com>
 <1389347850-22435-2-git-send-email-t-kristo@ti.com>
Message-ID: <20140110161422.GH6665@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 11:57:29AM +0200, Tero Kristo wrote:
> DRA7XX and AM43XX were missing common clock code from the Makefile, which
> causes build breakage in DRA7XX / AM43XX only builds once clock support
> for these SoCs is added. Add the missing entries to the Makefile as
> preparation of this.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140110/68bcb17c/attachment.sig>
