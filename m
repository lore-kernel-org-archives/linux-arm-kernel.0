From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 20 Nov 2012 09:20:46 +0100
Subject: [PATCH 207/493] i2c: remove use of __devinit
In-Reply-To: <1353349642-3677-207-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-207-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121120092046.24496415@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bill,

On Mon, 19 Nov 2012 13:22:36 -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.

Can you please point me/us to the discussion explaining the rationale
behind this move, and the explanation of what will be done exactly?
While I can easily understand that we want to drop CONFIG_HOTPLUG and
always enable hot-plug support, I don't see where we are going with
removing __devinit annotations and the like.

Thanks,
-- 
Jean Delvare
