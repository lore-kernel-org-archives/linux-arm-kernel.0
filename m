From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 3 Sep 2015 23:57:29 +0200
Subject: [PATCH] ARM: dts: Fix Makefile target for
 sun4i-a10-itead-iteaduino-plus
In-Reply-To: <20150902201812.GC464@hansolo.redhat.com>
References: <20150902201812.GC464@hansolo.redhat.com>
Message-ID: <20150903215729.GH31584@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh

On Wed, Sep 02, 2015 at 04:18:12PM -0400, Josh Boyer wrote:
> linux-kernel at vger.kernel.org
> Bcc: 
> Subject: [PATCH] ARM: dts: Fix Makefile target for sun4i-a10-itead-iteaduino-plus
> Reply-To: 

Hmmm, something went wrong with your mail header.

> ommit 79ae3e66f8d (ARM: dts: sun4i: Add Iteaduino Plus A10) added a new

Missing opening "C"

> make target for the sun4i-a10-itead-iteaduino-plus dts file, but mistakenly
> used .dts instead of the correct .dtb suffix.  This resulted in a build error
> like:
> 
> 	scripts/Makefile.dtbinst:42: target 'sun4i-a10-itead-iteaduino-plus.dts' doesn't match the target pattern
> 
> when doing a make dtbs_install.
> 
> Fix it to use the proper file name.
> 
> Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>

Apart from that, it looks fine, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150903/77d76f57/attachment-0001.sig>
