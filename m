From: olof@lixom.net (Olof Johansson)
Date: Mon, 27 May 2013 21:00:43 -0700
Subject: [PATCH 2/2] ARM: shmobile: r8A7779: fix Ether device name
In-Reply-To: <1369645206-3682-3-git-send-email-horms+renesas@verge.net.au>
References: <1369645206-3682-1-git-send-email-horms+renesas@verge.net.au>
 <1369645206-3682-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130528040043.GL13532@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Mon, May 27, 2013 at 06:00:06PM +0900, Simon Horman wrote:
> From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> While recasting the commit "ARM: shmobile: R8A7779: add Ether support", I made a
> typo in the platform device's name: used underscore instead of hyphen.

Minor nit: if this has been merged, then including the SHA is useful too.


-Olof
