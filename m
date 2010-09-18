From: gregkh@suse.de (Greg KH)
Date: Fri, 17 Sep 2010 22:38:49 -0700
Subject: [PATCH v2] power: introduce library for device-specific OPPs
In-Reply-To: <1284787459-25643-1-git-send-email-nm@ti.com>
References: <1284787459-25643-1-git-send-email-nm@ti.com>
Message-ID: <20100918053849.GA19709@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 18, 2010 at 12:24:19AM -0500, Nishanth Menon wrote:
> This is hence introduced under lib allowing all architectures to
> selectively enable the feature based on their capabilities.

<snip>

>  Documentation/power/00-INDEX |    2 +
>  Documentation/power/opp.txt  |  326 ++++++++++++++++++++++++++
>  drivers/base/power/Makefile  |    1 +
>  drivers/base/power/opp.c     |  527 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/opp.h          |  126 ++++++++++
>  kernel/power/Kconfig         |   14 ++
>  6 files changed, 996 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/power/opp.txt
>  create mode 100644 drivers/base/power/opp.c
>  create mode 100644 include/linux/opp.h

That doesn't look like the files are under lib/

Did you forget to move them, or do you need to update the changelog
message?

thanks,

greg k-h
