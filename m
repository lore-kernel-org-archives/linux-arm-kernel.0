From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Feb 2016 10:41:39 -0800
Subject: [PATCH] Add triggers for cubietruck leds
In-Reply-To: <1456304247-2481-1-git-send-email-henry@nitronetworks.nl>
References: <1456304247-2481-1-git-send-email-henry@nitronetworks.nl>
Message-ID: <20160225184139.GG4736@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 24, 2016 at 09:57:25AM +0100, Henry Paulissen wrote:
> This (small) patch gives the same led trigger functionality
> as the 3.4 sunxi kernel and although mainline doesn't has
> to be the same, it helps in identifying and builds upon the
> user expectations about what those leds mean.
> 
> Signed-off-by: Henry Paulissen <henry@nitronetworks.nl>

We don't take these trigger patches because it should be left for the
user to decide, and everyone has a different opinion on that.

It's something that you can also very easily enforce from the
userspace through sysfs.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160225/01239aa6/attachment.sig>
