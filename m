From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Oct 2015 13:04:06 +0000
Subject: [PATCH] ARM: fix bug in vdsomunge swab32 macro
In-Reply-To: <33027491.RBI25ragLG@wuerfel>
References: <130abb060734507d4affcf9d81b87ce6af5d2cc8.1446045045.git.hns@goldelico.com>
 <33027491.RBI25ragLG@wuerfel>
Message-ID: <20151030130405.GQ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2015 at 01:54:55PM +0100, Arnd Bergmann wrote:
> On Wednesday 28 October 2015 16:10:48 H. Nikolaus Schaller wrote:
> > Commit Commit 8a603f91cc48 ("ARM: 8445/1: fix vdsomunge not to depend on glibc specific byteswap.h")
> > 
> > unfortunately introduced a bug created but not found during
> > discussion and patch simplification.
> > 
> > Reported-by: Efraim Yawitz <efraim.yawitz@gmail.com>
> > Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> > ---
> > 
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Please add it to Russell's patch tracker at
> http://www.arm.linux.org.uk/developer/patches/

A patch very similar to this has already been merged (probably this
patch but submitted by Nathan.)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
