From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 8 Aug 2016 18:42:11 -0700
Subject: [PATCH 00/11] ARM: dts: NSP: define SATA, Reboot, RAM and new
 device tree files
In-Reply-To: <1470249546-12440-1-git-send-email-jon.mason@broadcom.com>
References: <1470249546-12440-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <fc5d767b-4ce1-c0d2-b2f5-cf2b5d2eb3c8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2016 11:38 AM, Jon Mason wrote:
> This patch series adds SATA and RAM for the existing HR and XMC device
> tree files (as they were missed when those peices were originally
> added).  It also adds GPIO rebooting to the platforms that support that
> feature.  Finally, add device tree files for all known NSP based
> reference boards.
> 
> The only outstanding HW that isn't fully supported on all NSP boards is
> USB and sound.  So, we're getting close :)
> 
> NOTE: SATA is not in the NSP DTSI in Florian's git tree, but it is
> currently in Linus' (due to it going through another maintainer).  So,
> it won't build until the merge with Linus' tree is done.  I thought it
> better to do it this way instead of splitting it off and sending it as
> a follow-on in a couple of weeks.  Let me know if it is preferred I do
> it that way.

Series applied, thanks Jon!
-- 
Florian
