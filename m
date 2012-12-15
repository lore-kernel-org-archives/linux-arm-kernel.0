From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 15 Dec 2012 07:29:32 +0000
Subject: [PATCH 4/7] ARM: sh7372: add clock lookup entries for DT-based
 devices
In-Reply-To: <1355503531-7276-5-git-send-email-g.liakhovetski@gmx.de>
References: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
 <1355503531-7276-5-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <20121215072932.3DC0B3E0C0F@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Dec 2012 17:45:28 +0100, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> When booting with DT, devices are named differently. To get their clocks
> additional entries have to be added to the lookup table.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Please use AUXDATA to manipulate the device name for consistency with
other platforms. When clock bindings get added to the device tree for
this platform then all the AUXDATA declarations can be removed.

g.
