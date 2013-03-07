From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 07 Mar 2013 01:11:21 +0100
Subject: [PATCH] ARM: S3C24XX: drop "select MACH_N35"
In-Reply-To: <013a01ce1ac7$11b287d0$35179770$%kim@samsung.com>
References: <1362609234.28137.2.camel@x61.thuisdomein>
 <013a01ce1ac7$11b287d0$35179770$%kim@samsung.com>
Message-ID: <1362615081.28137.5.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-03-07 at 09:02 +0900, Kukjin Kim wrote:

> BTW, so the machine type can be removed at arch/arm/tools/mach-types as well.

Well, that file has a big comment on top, containing the line:
    Please do not send patches to this file; it is automatically
generated!

So I didn't dare to touch it.


Paul Bolle
