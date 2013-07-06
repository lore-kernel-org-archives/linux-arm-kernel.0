From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 6 Jul 2013 18:37:02 +0200
Subject: [PATCH v5] ARM: sunxi: New watchdog driver for Allwinner A10/A13
In-Reply-To: <80d67226-1d83-475a-a94c-cfecc1cd277e@googlegroups.com>
References: <1370547265-24854-1-git-send-email-carlo.caione@gmail.com>
 <80d67226-1d83-475a-a94c-cfecc1cd277e@googlegroups.com>
Message-ID: <20130706163702.GA11243@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 06, 2013 at 07:39:13AM -0700, viniciusfre at gmail.com wrote:
> Hi Carlo,
> 
> It is not possible to enable this driver because there is no
> 'ARCH_SUNXI' in default .config. What you intended to use,
> 'ARCH_SUNXI' or 'ARCH_SUN4I'? RTC driver presents the same issue.

This driver is intended for the mainline Linux Kernel, where ARCH_SUN4i
doesn't exist, and ARCH_SUNXI actually does.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130706/cc645530/attachment.sig>
