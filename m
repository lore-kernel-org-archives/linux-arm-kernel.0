From: balbi@ti.com (Felipe Balbi)
Date: Fri, 20 Sep 2013 11:21:54 -0500
Subject: [PATCH] ARM: dts: am335x-boneblack: move fixed regulator to
 board level
In-Reply-To: <1379610764-758-1-git-send-email-nm@ti.com>
References: <1379610764-758-1-git-send-email-nm@ti.com>
Message-ID: <20130920162154.GB18721@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 12:12:44PM -0500, Nishanth Menon wrote:
> 3.3V fixed regulator does not belong to TPS node - as a result
> the fixed regulator is never probed and MMC is continually deferred due
> to lack of regulator.
> 
> Move the fixed regulator to be at root of platform.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Tested-by: Felipe Balbi <balbi@ti.com>

I boot tested this on my BBB.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130920/d67cbab2/attachment-0001.sig>
