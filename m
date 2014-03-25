From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 25 Mar 2014 10:32:32 +0100
Subject: [PATCH 00/10] ARM: mvebu: Hardware coherency support for Armada
 375 and 38x
In-Reply-To: <20140324160620.607c77cd@skate>
References: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140324160620.607c77cd@skate>
Message-ID: <20140325093232.GH14983@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 04:06:20PM +0100, Thomas Petazzoni wrote:
> Jason, Gregory, Andrew, Sebastian,
> 
> Any news about this patch set? It is not aimed at 3.15 as was discussed
> already with Jason, but since I'd still like to have some early
> comments about this patch series for 3.16, since we would also like to
> land the Armada 375/38x SMP support in 3.16, which will sit on top of
> this series.

Hi Thomas

I took a look at them. The XOR code is interesting. I guess it is not
good for performance. A loud debug message would be useful to know
when the workaround has been turned on.

Once you send a rebase on 3.15 i can send an ACK.

     Andrew
