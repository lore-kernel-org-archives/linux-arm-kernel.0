From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 11 Feb 2013 10:00:54 +0100
Subject: [PATCH] Added support for pogoplug e02 (pink/gray)
In-Reply-To: <1360540418-14133-1-git-send-email-ottxor@gentoo.org>
References: <1360540418-14133-1-git-send-email-ottxor@gentoo.org>
Message-ID: <20130211100054.1049246c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Christoph Junghans,

On Sun, 10 Feb 2013 16:53:38 -0700, Christoph Junghans wrote:
> The pogoplug differs from the SheevaPlug only by a
> few details, but especially in the led assignments.
> This patch was tested under Gentoo Linux.
> A version of this patch was included in Arch Linux
> on Arm since Jan 2012:
>    https://github.com/archlinuxarm/PKGBUILDs/pull/124
> A similar patch is available for OpenWrt:
>   http://patchwork.openwrt.org/patch/1412/
> 
> Signed-off-by: Christoph Junghans <ottxor@gentoo.org>

All new platforms should be supported by adding a Device Tree source
file, rather than using old-style C board files. Could you convert this
to the Device Tree and resubmit?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
