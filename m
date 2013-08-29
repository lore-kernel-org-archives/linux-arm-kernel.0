From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Aug 2013 10:15:20 -0700
Subject: [GIT PULL 2/2] ARM: mvebu: MSI mvebu changes for v3.12
In-Reply-To: <20130814192317.GE13964@titan.lakedaemon.net>
References: <20130814191011.GD13964@titan.lakedaemon.net>
 <20130814192317.GE13964@titan.lakedaemon.net>
Message-ID: <20130829171520.GE18542@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 03:23:17PM -0400, Jason Cooper wrote:
> Arnd, Olof,
> 
> This branch has a conflict with mvebu/drivers (the MBus dt binding work)
> that is rather extensive.  I've attached the resolution that has been
> in -next below the summary.

So this is a textbook example of when you should resolve the conflicts in your
own tree by building the branches on top of each other.

Your proposed resolutions don't match what I get in my tree, and don't match
what is in linux-next right now. Please resend this based on top of
mvebu/drivers and I'll pull it in as a late branch for 3.12.


-Olof
