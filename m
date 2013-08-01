From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 1 Aug 2013 13:38:45 -0400 (EDT)
Subject: [PATCH] USB: ohci-at91: add usb_clk for transition to common
 clk framework
In-Reply-To: <51FA9B20.3080304@cogentembedded.com>
Message-ID: <Pine.LNX.4.44L0.1308011338090.1534-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Aug 2013, Sergei Shtylyov wrote:

> > Yes.  However, a more elegant approach is to protect the relevant
> > statements with: if (defined(CONFIG_COMMON_CLK)).  This preprocessor
> 
>     You probably meant IS_ENABLED() or IS_BUIILTIN()? Or is there something I 
> don't know about gcc preprocessor?

Yes, sorry, I meant IS_ENABLED().  Boris got it right.

Alan Stern
