From: horms@verge.net.au (Simon Horman)
Date: Thu, 12 Jun 2014 09:19:08 +0900
Subject: [PATCH 0/2] Add VIN and ADV7180 DT support for R8A7791/Henninger
 board
In-Reply-To: <53984E7D.8010909@cogentembedded.com>
References: <201406110304.18976.sergei.shtylyov@cogentembedded.com>
 <20140610235445.GE20738@verge.net.au>
 <53984E7D.8010909@cogentembedded.com>
Message-ID: <20140612001908.GA11549@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 04:41:33PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 06/11/2014 03:54 AM, Simon Horman wrote:
> 
> >>    Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
> >>'renesas-devel-v3.15-20140610' tag plus the Henninger I2C2 DT support patch
> >>that I posted earlier. Here we add the VIN and ADV7180 video decoder device
> >>tree support on the R8A7791/Henninger board. The patchset requires Ben Dooks'
> >>adv7180, rcar_vin, and soc_camera DT support patches posted back in April in
> >>order to work.
> 
> >I wonder what the status of those (driver?) patches are.
> 
>    Someone in CodeThink is working on them, I was told. I had to fix them up
> somewhat in order for them to compile.
> 
> >In general I prefer bindings to be accepted before they are used.
> 
>    No argument here. I just have my own schedule.

No argument there either :)
