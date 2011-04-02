From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 2 Apr 2011 16:31:32 +0800
Subject: [PATCH 1/1] net/fec: do not pass NULL dev to DMA API
In-Reply-To: <20110402.005714.258110130.davem@davemloft.net>
References: <1301726391-7431-1-git-send-email-b29396@freescale.com>
	<20110402.005714.258110130.davem@davemloft.net>
Message-ID: <20110402083131.GB26533@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Sat, Apr 02, 2011 at 12:57:14AM -0700, David Miller wrote:
> 
> First, your patches never make it to the mailing list because the list
> server rejects your postings, due to the fact that there are syntax
> errors in your email headers:
> 
> Illegal-Object:	Syntax error in From: address found on vger.kernel.org:
> 	From:	Aisheng.Dong<b29396@freescale.com>
> 				    ^-missing end of mailbox
> 
Yes, we were aware of that the mail did not get distributed by vger
list.  But we do not know why.  Thanks for telling.

I'm not quite sure about the "^" indication.  Is it telling that there
should be a space between display name and mail address?

-- 
Regards,
Shawn
