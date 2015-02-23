From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Feb 2015 19:36:21 +0000
Subject: [PATCH 1/2] ARM: kernel: add support for cpu cache information
In-Reply-To: <1424716091-22914-1-git-send-email-sudeep.holla@arm.com>
References: <1424716091-22914-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20150223193621.GP8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 23, 2015 at 06:28:10PM +0000, Sudeep Holla wrote:
> This patch adds support for cacheinfo on ARM platforms.

These patches should carry with them the justification for exporting
this information to userspace.

"Because we can" is not a good reason; once exported, this information
becomes a userspace API that we have to maintain, and thus it comes
with a non-zero support cost going forward.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
