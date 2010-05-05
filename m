From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 May 2010 09:59:32 +0100
Subject: [RESEND PATCHv3 0/4] Adding soc related info into /proc/cpuinfo
In-Reply-To: <1273048928-6105-1-git-send-email-eduardo.valentin@nokia.com>
References: <1273048928-6105-1-git-send-email-eduardo.valentin@nokia.com>
Message-ID: <20100505085932.GA7703@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 05, 2010 at 11:42:04AM +0300, Eduardo Valentin wrote:
> I'm resending this series with minor change in the subject prefix of patch 4/4.
> Removed the PM: prefix. Everything else is same. So, I kept the v3 prefix as well.

I'd much prefer to see a /proc/socinfo rather than extending
/proc/cpuinfo to further include stuff which isn't CPU related.
