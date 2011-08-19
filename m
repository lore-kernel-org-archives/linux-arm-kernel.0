From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 19 Aug 2011 23:02:10 +0100
Subject: [PATCH v2] ARM: S3C64XX: Use module identification for
	Craggamore system builds
In-Reply-To: <004101cc5e77$3ad49030$b07db090$%kim@samsung.com>
References: <1313498575-13465-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<004101cc5e77$3ad49030$b07db090$%kim@samsung.com>
Message-ID: <20110819220210.GB3772@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 10:52:26PM +0900, Kukjin Kim wrote:
> Mark Brown wrote:

Please delete unneeded context from mails, it makes it much easier to
find the reply.

> > -#include <sound/wm8996.h>

> Hmm...Why is this <sound/wm8915.h> in my tree?

This was waiting for cross tree issues to settle down in the merge
window before being applied - it's in -rc2 which appeared last week or
you can pull the individual change from:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git wm8996-rename
