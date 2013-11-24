From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 23 Nov 2013 21:48:13 -0500
Subject: [PATCH 1/3] ARM: Orion: Add missing includes
In-Reply-To: <1382537572-31472-1-git-send-email-y>
References: <y>
 <1382537572-31472-1-git-send-email-y>
Message-ID: <20131124024813.GN29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 04:12:50PM +0200, y at lunn.ch wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> Building with C=1 generates warnings because of missing includes and
> static keywords. Add them.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/plat-orion/common.c | 9 +++++----
>  arch/arm/plat-orion/time.c   | 1 +
>  2 files changed, 6 insertions(+), 4 deletions(-)

Whole series applied to mvebu/soc

thx,

Jason.
