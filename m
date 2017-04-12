From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Apr 2017 16:53:36 +0100
Subject: [PATCH 2/6] regulator: anatop: only set supply regulator when it
 actually exists
In-Reply-To: <20170413071101.GA23163@b29396-OptiPlex-7040>
References: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
 <1491962327-12477-2-git-send-email-aisheng.dong@nxp.com>
 <20170411203124.y7cwyttqfu4a2aov@sirena.org.uk>
 <20170413071101.GA23163@b29396-OptiPlex-7040>
Message-ID: <20170412155336.vhhrftqmlxhti36n@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 03:11:01PM +0800, Dong Aisheng wrote:

> You're absolutely right!
> I did this because there're some where else did the same thing.
> e.g. drivers/regulator/fixed.c.

> But it's obviously none of any platform specific and is perfectly
> to be handled in regulator core.

Did my patch solve the problems you were seeing?  I just wrote it
quickly last thing before I finished for the evening.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170412/4e5466b1/attachment.sig>
