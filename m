From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 14 Nov 2011 08:49:54 -0800
Subject: [PATCH] dts: tegra-ventana: use proper root instead of /dev/ram
In-Reply-To: <1321251032-5461-1-git-send-email-vwadekar@nvidia.com>
References: <1321251032-5461-1-git-send-email-vwadekar@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1740805A99@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Varun Wadekar wrote at Sunday, November 13, 2011 11:11 PM:
> the root file system on ventana resides on /dev/mmcblk0p1.

"The" should be capitalized.

> update the dts file to use the proper root instead of /dev/ram.
> 
> Original-author: Pritesh Raithatha <praithatha@nvidia.com>
> Signed-off-by: Varun Wadekar <vwadekar@nvidia.com>

If Pritesh did write this, and you didn't significantly rewrite it, you
should probably re-send this after fixing the authorship information in
git; that way "git format-patch" will emit a "From" line with Pritesh's
information into the email body, so that the author field is set correctly
when this is merged. Assuming this is the most recent commit in your branch,
you'd do:

git commit --amend --author='Pritesh Raithatha <praithatha@nvidia.com>'

(although I also wonder why Pritesh didn't sign it off)

The content of the patch seems fine to me.

-- 
nvpublic
