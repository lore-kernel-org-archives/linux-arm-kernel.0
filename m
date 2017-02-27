From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Feb 2017 15:40:37 +0100
Subject: [PATCH 7/8] ARM: sunxi: Select PM_OPP
In-Reply-To: <e1424c55f3f8b1176f24a446936d189b00383a4c.1486655917.git-series.maxime.ripard@free-electrons.com>
References: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
 <e1424c55f3f8b1176f24a446936d189b00383a4c.1486655917.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170227144037.qvys7jczmmjkgvla@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 05:39:21PM +0100, Maxime Ripard wrote:
> Device frequency scaling is implemented through devfreq in the kernel,
> which requires CONFIG_PM_OPP.
> 
> Let's select it.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied.
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170227/6b951498/attachment.sig>
