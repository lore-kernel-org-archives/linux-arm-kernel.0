From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Oct 2013 13:54:23 -0400
Subject: [PATCH v2 0/2] ARM: Dove: Add audio to the DT
In-Reply-To: <20131008194055.00fc93c2@armhf>
References: <20131008194055.00fc93c2@armhf>
Message-ID: <20131008175423.GT5402@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean-Francois,

On Tue, Oct 08, 2013 at 07:40:55PM +0200, Jean-Francois Moine wrote:
> This patch series adds audio DT to the Dove boards and activates the
> Cubox audio device.
> 
> Full audio in the Cubox will work when the DT extension of the generic
> simple audio card will be complete.
> 
> v2:
> - dove.dtsi: change the audio controller compatible string to
> 	"marvell,dove-audio" (Thomas Petazzoni)
> - dove-cubox: add the external clock (Sebastian Hesselbarth)

Thanks for turning this around so quickly.  Sebastian, if I could get
your Acked-by on this series, I'll pull it in.

thx,

Jason.
