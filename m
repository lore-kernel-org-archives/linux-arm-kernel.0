From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 4 Aug 2011 00:21:56 +0530
Subject: [PATCH 1/1] davinci: dm646x: move vpif related code to driver
	core	header from platform
In-Reply-To: <1305899929-2509-1-git-send-email-manjunath.hadli@ti.com>
References: <1305899929-2509-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DF05EB0@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Manju,

On Fri, May 20, 2011 at 19:28:49, Hadli, Manjunath wrote:
> move vpif related code for capture and display drivers
> from dm646x platform header file to vpif.h as these definitions
> are related to driver code more than the platform or board.
> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>

Can you rebase this patch to latest on my tree and repost
this time CCing Mauro?

Lets try and get his ack for the v3.2 merge.

Thanks,
Sekhar
