From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 14 Aug 2012 14:23:24 -0400
Subject: [patch v2 1/1] ARM: Orion: Set eth packet size csum offload limit
In-Reply-To: <20120726101601.284809510@rtp-net.org>
References: <20120726101601.284809510@rtp-net.org>
Message-ID: <20120814182324.GO22226@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 12:15:46PM +0200, Arnaud Patard wrote:
> The mv643xx ethernet controller limits the packet size for the TX
> checksum offloading. This patch sets this limits for Kirkwood and
> Dove which have smaller limits that the default.
> 
> As a side note, this patch is an updated version of a patch sent some years
> ago: http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/017320.html
> which seems to have been lost.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

Applied to:

git://git.infradead.org/users/jcooper/linux.git fixes-for-v3.6

thx,

Jason.
