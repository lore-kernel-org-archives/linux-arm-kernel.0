From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 28 Feb 2018 20:57:18 +0300
Subject: [PATCH v2 0/5] Add R8A77970/V3MSK LVDS/HDMI support
In-Reply-To: <20180228132707.mgunezg5o4lul7x5@verge.net.au>
References: <23a6ac28-134b-b5dd-69a7-910774c4b8c1@cogentembedded.com>
 <2fd26075-525c-8d86-ef81-f32c73cf3e8b@cogentembedded.com>
 <20180228132707.mgunezg5o4lul7x5@verge.net.au>
Message-ID: <f9574ea2-d8ee-7c9f-b850-874074eddad2@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2018 04:27 PM, Simon Horman wrote:

>>> Here's the set of 5 patches against Simon Horman's 'renesas.git' repo's
>>> 'renesas-devel-20180227-v4.16-rc3' tag. We're adding the R8A77970 FCPVD/VSPD/
>>> DU/LVDS device nodes and then describing the HDMI encoder connected to the LVDS
>>> output (we're omitting the LVDS decoder for now). These patches depend on
>>> the recent R8A77970 DU/LVDS rework patches by Laurent in order to work...	
>>
>>    Need to mention that the DU driver silently fails to probe now. I do
>>    hope that this is not due to my updates. :-)
> 
> Please test that theory.

   Yeah, after sucking in the recent versions of the DU/LVDS patches and uncommenting
and fixing rejects in a couple patches here, the graphical console works again. :-)

MBR, Sergei
