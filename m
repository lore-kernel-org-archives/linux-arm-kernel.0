From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 6 Sep 2015 13:20:46 +0200
Subject: [PATCH RESEND] ARM: dts: Fix Makefile target for
 sun4i-a10-itead-iteaduino-plus
In-Reply-To: <20150904124934.GD464@hansolo.redhat.com>
References: <20150904124934.GD464@hansolo.redhat.com>
Message-ID: <20150906112046.GK31584@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 08:49:34AM -0400, Josh Boyer wrote:
> Commit 79ae3e66f8d (ARM: dts: sun4i: Add Iteaduino Plus A10) added a new
> make target for the sun4i-a10-itead-iteaduino-plus dts file, but mistakenly
> used .dts instead of the correct .dtb suffix.  This resulted in a build error
> like:
> 
>         scripts/Makefile.dtbinst:42: target 'sun4i-a10-itead-iteaduino-plus.dts' doesn't match the target pattern
> 
> when doing a make dtbs_install.
> 
> Fix it to use the proper file name.
> 
> Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>

Queued, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150906/1c971668/attachment.sig>
