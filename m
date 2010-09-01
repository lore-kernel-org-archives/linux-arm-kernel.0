From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Sep 2010 10:14:55 +0100
Subject: [PATCH 2/7] wire up sys_time_change_notify() on ARM
In-Reply-To: <1283255151-6364-2-git-send-email-virtuoso@slind.org>
References: <1283255151-6364-1-git-send-email-virtuoso@slind.org>
	<1283255151-6364-2-git-send-email-virtuoso@slind.org>
Message-ID: <20100901091455.GL8142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 31, 2010 at 02:45:46PM +0300, Alexander Shishkin wrote:
> sys_time_change_notify() is a new syscall with number and types of
> parameters such that no ARM-specific processing is needed.

This patch needs to be redone.  Please wait until I've finished catching
up with the last 10 or so days of email and merged my tree into mainline.
Alternatively, update your patch to apply on top of my master branch.
