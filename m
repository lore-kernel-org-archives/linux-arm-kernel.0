From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Mar 2012 19:39:35 -0800
Subject: [PATCH v3 06/10] pwm: Add NVIDIA Tegra SoC support
In-Reply-To: <20120303224212.GA6661@avionic-0098.mockup.avionic-design.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <1329923841-32017-7-git-send-email-thierry.reding@avionic-design.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF1E63@HQMAIL01.nvidia.com>
 <20120303224212.GA6661@avionic-0098.mockup.avionic-design.de>
Message-ID: <20120305033935.GA32675@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2012 at 11:42:12PM +0100, Thierry Reding wrote:

> Those probably weren't there yet when I prepared the first series. I'll have
> another look will sync up with it after testing that it still works.


Yep, the patch in question is from Simon, and it's at:

http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel.git;a=commitdiff;h=7778c724bf3211c534f9bcef7b26afc6cb067a82

Essentially, the driver accidentally rounded down a backlight setting of
'1' which is how it was found.


-Olof
