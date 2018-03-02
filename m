From: horms@verge.net.au (Simon Horman)
Date: Fri, 2 Mar 2018 11:21:06 +0100
Subject: [PATCH v2 0/5] Add R8A77970/V3MSK LVDS/HDMI support
In-Reply-To: <5f65b46d-be0f-a1ae-3d97-37f62ecf1657@cogentembedded.com>
References: <23a6ac28-134b-b5dd-69a7-910774c4b8c1@cogentembedded.com>
 <2fd26075-525c-8d86-ef81-f32c73cf3e8b@cogentembedded.com>
 <20180228132707.mgunezg5o4lul7x5@verge.net.au>
 <f9574ea2-d8ee-7c9f-b850-874074eddad2@cogentembedded.com>
 <20180301095451.jvsybu5k6pnahfbi@verge.net.au>
 <5f65b46d-be0f-a1ae-3d97-37f62ecf1657@cogentembedded.com>
Message-ID: <20180302102106.enyb2ldmylgklqom@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 06:28:29PM +0300, Sergei Shtylyov wrote:
> On 03/01/2018 12:54 PM, Simon Horman wrote:
> 
> >>>>> Here's the set of 5 patches against Simon Horman's 'renesas.git' repo's
> >>>>> 'renesas-devel-20180227-v4.16-rc3' tag. We're adding the R8A77970 FCPVD/VSPD/
> >>>>> DU/LVDS device nodes and then describing the HDMI encoder connected to the LVDS
> >>>>> output (we're omitting the LVDS decoder for now). These patches depend on
> >>>>> the recent R8A77970 DU/LVDS rework patches by Laurent in order to work...	
> >>>>
> >>>>    Need to mention that the DU driver silently fails to probe now. I do
> >>>>    hope that this is not due to my updates. :-)
> >>>
> >>> Please test that theory.
> >>
> >>    Yeah, after sucking in the recent versions of the DU/LVDS patches and uncommenting
> >> and fixing rejects in a couple patches here, the graphical console works again. :-)
> > 
> > Ok, but does this patchset cause a regression? If so it seems
> 
>     Sorry, somehow missed that question. No regression is possible as the display just
> doesn't work before these patches are applied. It's just that it doesn't start to work
> until the recent DU/LVDS driver updates are applied.

Ok, but my question remains: does the display work before these patches?
