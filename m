From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Wed, 04 Jul 2012 17:02:30 +0300
Subject: [PATCH] clk: mxs: imx28: decrease the frequency of ref_io1 for
 SSP2 and SSP3
In-Reply-To: <20120704133554.GB2595@S2101-09.ap.freescale.net>
References: <1341398994-28028-1-git-send-email-lauri.hintsala@bluegiga.com>
 <20120704133554.GB2595@S2101-09.ap.freescale.net>
Message-ID: <4FF44CF6.90805@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2012 04:35 PM, Shawn Guo wrote:
> On Wed, Jul 04, 2012 at 01:49:54PM +0300, Lauri Hintsala wrote:
>> SSP0 and SSP1 use ref_io0 which has decreased frequency. Expand
>> the frequency fix for ref_io1 to get SSP2 and SSP3 to work.
>>
> The patch looks okay.  Just to confirm that you are running SSP2&SSP3
> into the same frequency problem that we had with SSP0&SSP1?  I never
> got a board to verify that for SSP2&SSP3.

SDIO device connected to SSP2 is not detect without this change. I don't 
know what is the history of ref_io0 frequency change but the same change 
is needed for ref_io1 to get SSP2 to work on our imx28 based module.

Regards,
Lauri
