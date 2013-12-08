From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 7 Dec 2013 20:04:14 -0500
Subject: [PATCH v2 0/2] ARM: DT: Kirkwood: Use symbolic names
In-Reply-To: <1386172299-9105-1-git-send-email-andrew@lunn.ch>
References: <1386172299-9105-1-git-send-email-andrew@lunn.ch>
Message-ID: <20131208010414.GG11251@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 04:51:37PM +0100, Andrew Lunn wrote:
> This patchset makes use of the symbolic names in input.h and gpio.h
> within the Kirkwood DT files.
> 
> Since v1:
>   Drop ReadyNAS hunks
>   Rebase on mvebu/dt and fix all the conflicts
>   Remove the now redundant includes in the ReadyNAS .dts files.
> 
> Andrew Lunn (2):
>   ARM: DT: Kirkwood: Use symbolic names from input.h
>   ARM: DT: Kirkwood: Use symbolic names from gpio.h

Applied to mvebu/dt

thx,

Jason.
