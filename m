From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 May 2015 11:09:50 +0800
Subject: [PATCH v3] imx27: dt: only map 4 Kbyte for fec registers
In-Reply-To: <1431469106-27666-1-git-send-email-tremyfr@gmail.com>
References: <1431469106-27666-1-git-send-email-tremyfr@gmail.com>
Message-ID: <20150514030948.GA6850@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 12:18:26AM +0200, Philippe Reynes wrote:
> According to the imx27 documentation, fec has a 4 Kbyte
> memory space map. Moreover, the actual 16 Kbyte mapping
> overlaps the SCC (Security Controller) memory register
> space. So, we reduce the memory register space to 4 Kbyte.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Updated the patch prefix as "ARM: dts: imx27: ", and applied.  Thanks.

Shawn
