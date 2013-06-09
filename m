From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sun, 9 Jun 2013 11:39:43 -0300
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130609014506.GB10027@obsidianresearch.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1370623671-7748-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306072101.44694.arnd@arndb.de>
 <20130607200054.GA9010@obsidianresearch.com>
 <20130608183851.GB2354@localhost>
 <20130609014506.GB10027@obsidianresearch.com>
Message-ID: <20130609143941.GB2353@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 08, 2013 at 07:45:06PM -0600, Jason Gunthorpe wrote:
> On Sat, Jun 08, 2013 at 03:38:52PM -0300, Ezequiel Garcia wrote:
[...]
> 
> There are lots and lots of solutions using the pre-processor, please
> take a look and find one that you feel works for you...
> 

Ok, I will.

> 
> We can always improve the dtc envorionment (as was done recently by
> adding the preprocessor), we cannot change 'DT ABI' once it it set.
>

Right. Let me rework this using the preprocessor and send a v2.

Thanks for the feedback!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
