From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 May 2013 00:09:57 +0100
Subject: [PATCH -v7 08/11] arm, Remove unused restart_mode fields from
 some arm subarchs
In-Reply-To: <1367428011-17123-9-git-send-email-holt@sgi.com>
References: <1367428011-17123-1-git-send-email-holt@sgi.com>
 <1367428011-17123-9-git-send-email-holt@sgi.com>
Message-ID: <20130501230957.GS14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 01, 2013 at 12:06:48PM -0500, Robin Holt wrote:
> These restart_mode fields are not used at all.  Remove them to make
> moving the reboot= cmdline options to the general kernel easier.

Your grepping is faulty.  They are most definitely used.
