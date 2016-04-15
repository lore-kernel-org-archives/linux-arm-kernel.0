From: holgerschurig@gmail.com (Holger Schurig)
Date: Fri, 15 Apr 2016 10:33:37 +0200
Subject: [PATCH net-next V3 00/16] net: fec: cleanup and fixes
In-Reply-To: <570FB998.2080900@boundarydevices.com> (Troy Kisky's message of
 "Thu, 14 Apr 2016 08:39:04 -0700")
References: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
 <87h9f4ebvp.fsf@gmail.com> <570FB998.2080900@boundarydevices.com>
Message-ID: <87bn5bp8ym.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I think I've already fixed this, but I've only submitted once.
>
> commit 466cb4a2e5583d2e18470f30d5948edcf4b947f5
> Author: Troy Kisky <troy.kisky@boundarydevices.com>
> Date:   Wed Jan 20 12:52:10 2016 -0700
>
>     net: fec: update dirty_tx even if no skb
>
>     If dirty_tx isn't updated, then dma_unmap_single
>     will be called twice.
>
>     Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

Thanks!   This fixed the issue.  Have a

Tested-by: <holgerschurig@gmail.com>
