From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 5 Mar 2012 08:00:50 +0100
Subject: [PATCH v3 06/10] pwm: Add NVIDIA Tegra SoC support
In-Reply-To: <20120305033935.GA32675@quad.lixom.net>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <1329923841-32017-7-git-send-email-thierry.reding@avionic-design.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF1E63@HQMAIL01.nvidia.com>
 <20120303224212.GA6661@avionic-0098.mockup.avionic-design.de>
 <20120305033935.GA32675@quad.lixom.net>
Message-ID: <20120305070050.GA10914@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson wrote:
> On Sat, Mar 03, 2012 at 11:42:12PM +0100, Thierry Reding wrote:
> 
> > Those probably weren't there yet when I prepared the first series. I'll have
> > another look will sync up with it after testing that it still works.
> 
> 
> Yep, the patch in question is from Simon, and it's at:
> 
> http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel.git;a=commitdiff;h=7778c724bf3211c534f9bcef7b26afc6cb067a82
> 
> Essentially, the driver accidentally rounded down a backlight setting of
> '1' which is how it was found.

Thanks for the link, I'll squash it into this patch in the next version.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120305/966b89ca/attachment.sig>
