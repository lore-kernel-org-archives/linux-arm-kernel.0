From: horms@verge.net.au (Simon Horman)
Date: Tue, 10 Nov 2015 09:13:21 +0900
Subject: [PATCH 2/2] ARM: shmobile: gose: Configure PFC in DT
In-Reply-To: <9791748.jMTWEhtVrm@avalon>
References: <1447032799-13155-1-git-send-email-horms+renesas@verge.net.au>
 <1447032799-13155-3-git-send-email-horms+renesas@verge.net.au>
 <9791748.jMTWEhtVrm@avalon>
Message-ID: <20151110001320.GC1040@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 04:16:45PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Monday 09 November 2015 10:33:19 Simon Horman wrote:
> > Configure PFC for the already enabled scif and ethernet devices
> > in the device tree for the gose board.
> > 
> > Based on similar work for the koelsch board by Laurent Pinchart and
> > Sergei Shtylyov.
> 
> I can't really comment on the patch due to lack of a schematics for the Goose 
> board, but it looks good to me in principle.
> 
> Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I have queued up both patches of this series.
