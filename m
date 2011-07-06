From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 6 Jul 2011 15:29:10 +0530
Subject: [PATCH 1/1] davinci: dm646x: move vpif related code to driver
	core	header from platform
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D6262FF@dbde02.ent.ti.com>
References: <1305899929-2509-1-git-send-email-manjunath.hadli@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D2D28E3@dbde02.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6262FF@dbde02.ent.ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D91ABC6@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

On Wed, Jun 22, 2011 at 09:35:58, Nori, Sekhar wrote:
> On Thu, Jun 02, 2011 at 22:51:58, Nori, Sekhar wrote:
> > Hi Mauro,
> > 
> > On Fri, May 20, 2011 at 19:28:49, Hadli, Manjunath wrote:
> > > move vpif related code for capture and display drivers
> > > from dm646x platform header file to vpif.h as these definitions
> > > are related to driver code more than the platform or board.
> > > 
> > > Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> > 
> > Will you be taking this patch through your tree?
> > 
> > If not, with your ack, I can queue it for inclusion
> > through the ARM tree.
> > 
> 
> Ping :)

Can you please provide your ack so that I can
queue this for v3.1?

Thanks,
Sekhar
