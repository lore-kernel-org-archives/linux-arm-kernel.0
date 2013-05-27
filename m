From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 27 May 2013 11:41:13 -0400
Subject: [PATCH 00/21] ARM: kirkwood: improve pinmux configs in Device Tree
In-Reply-To: <20130527.181018.461275386.yamagata@plathome.co.jp>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130527.181018.461275386.yamagata@plathome.co.jp>
Message-ID: <20130527154113.GG31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

On Mon, May 27, 2013 at 06:10:18PM +0900, yamagata at plathome.co.jp wrote:
> > The last patch finally adds support for the init button of the
> > Plathome OpenBlocks A6 platform.
> 
> I have checked the init button worked well with your three patches for
> linux-3.10-rc3 and 3.9.4.
> 
> Tested-by: Atsushi Yamagata <yamagata@plathome.co.jp>

Added the above to the relevant patches, as well as Andrew's Ack's and
his Tested-by's on topkick and ts219.

FYI: mvebu/dt has been rebased *after* tags/dt-3.11-2.  Actually, I
rebased after '0e99b15 arm: mvebu: enable two USB interfaces on the
Armada XP GP board'.  The important thing is that what was rebased is
*not* in arm-soc, nor has a pending PR for arm-soc.

thx,

Jason.
