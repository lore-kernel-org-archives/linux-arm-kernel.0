From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 14:01:57 -0800
Subject: [PATCH] dtb: amd: Fix-up for ccn504 and kcs nodes
In-Reply-To: <1455236443-23949-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1455236443-23949-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <20160224220157.GP10126@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 07:20:43AM +0700, Suravee Suthikulpanit wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> This is a fix-up patch based on the review comment from
> Arnd regarding:
>     * fix ccn504 address in the node name
>     * remove kcs interrupt-name
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
> 
> Hi Olof,
> 
> Here are the changes from the V3 that I sent earlier. Sorry for confusion.
> Would you please pull this into the next tree?
> 
> Thank you,
> Suravee

Applied.

I also noticed that the patch subjects were nonstandard the last time around.
In the future, please use:

arm64: dts: amd: ...

as prefix, instead of just dtb (which is the binary format). I fixed it up for
this patch, and the others, well, they're already applied. So let's try to
remember it for the future.


-Olof
