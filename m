From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 9 Feb 2015 13:11:03 +0100
Subject: [PATCH v9 3/3] ARM: dts: add I2C device nodes for Broadcom Cygnus
In-Reply-To: <1423373126-30024-4-git-send-email-rjui@broadcom.com>
References: <rjui@broadcom.com>
 <1423373126-30024-1-git-send-email-rjui@broadcom.com>
 <1423373126-30024-4-git-send-email-rjui@broadcom.com>
Message-ID: <20150209121103.GC2491@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 07, 2015 at 09:25:26PM -0800, Ray Jui wrote:
> Add I2C device nodes and its properties in bcm-cygnus.dtsi but keep
> them disabled there. Individual I2C devices can be enabled in board
> specific dts file when I2C slave devices are enabled in the future
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> Reviewed-by: Kevin Cernekee <cernekee@chromium.org>

I usually don't take DTS patches. They should go via arm-soc. Please say
so if there are reasons I should take them.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150209/c0a1ad9e/attachment.sig>
