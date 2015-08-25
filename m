From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Aug 2015 16:42:42 -0700
Subject: [PATCH 5/5] MAINTAINERS: add entry for the Broadcom Northstar
 Plus SoCs
In-Reply-To: <1440092861-25825-1-git-send-email-jonmason@broadcom.com>
References: <1440092861-25825-1-git-send-email-jonmason@broadcom.com>
Message-ID: <CAOesGMioBQY9qy-S8kMJmo_=B6-KZiUkd=Ns1Uo2dGu0BiqppQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 10:47 AM, Jon Mason <jonmason@broadcom.com> wrote:
> Modify the iProc MAINTAINER to cover the Nortstar Plus SoCs, and add me
> to the list of people responsible for it.

That's not what this patch does. It removes CYGNUS from the
description as well. Hmm?

I'm also not a fan of the complex patterns, but that's more of a
bikeshedding comment. Does Broadcom really not have a bit more
systematic naming than this? :)

> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

For maintainer updates, we usuallu like to see a public ack of this
and not just a pre-acked patch. You _could_ have added it yourself
without Scott's actual approval, after all.


-Olof
