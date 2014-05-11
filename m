From: olof@lixom.net (Olof Johansson)
Date: Sat, 10 May 2014 20:20:39 -0700
Subject: [PATCH] ARM: dts: i.MX53: Fix ipu register space size
In-Reply-To: <20140506125802.GB2870@dragon>
References: <1399374094-32451-1-git-send-email-s.hauer@pengutronix.de>
 <20140506125802.GB2870@dragon>
Message-ID: <20140511032039.GB22931@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 06, 2014 at 08:58:04PM +0800, Shawn Guo wrote:
> On Tue, May 06, 2014 at 01:01:34PM +0200, Sascha Hauer wrote:
> > The IPU register space is 128MB, not 2GB.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Acked-by: Shawn Guo <shawn.guo@freescale.com>
> 
> Arnd, Olof,
> 
> Please apply this fix for 3.15, and copy stable.  Thanks.
> 
> Cc: <stable@vger.kernel.org>
> 

Applied, but in the future please resend the whole patch since we just
get this acked-by email in the arm at kernel.org mailboxes and have to hunt
around for the original patch.

Btw for the future, this is the case where a Fixes: <12-digit sha> '<patch
subject>' would be useful, so that stable knows how far to backport. I added it
this time as well, feel free to do it yourself next time :)



-Olof
