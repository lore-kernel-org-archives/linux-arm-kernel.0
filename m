From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 May 2017 11:22:13 +0200
Subject: [PATCH 6/6] arm64: dts: marvell: enable GICP and ICU
In-Reply-To: <1496135772-20694-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20170530112213.40e7bdb4@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 30 May 2017 11:16:12 +0200, Thomas Petazzoni wrote:
> This commit modifies the Marvell EBU Armada 7K and 8K Device Tree files
> to describe the ICU and GICP units, and use ICU interrupts for all
> devices in the CP110 blocks.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Please disregard this patch. I should remember all patches before using
"git format-patch", this would avoid me sending stale versions of
patches.

Basically the other PATCH 6/6 is exactly the same, with just the title
changed (and is the more correct one).

Sorry about that,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
