From: davem@davemloft.net (David Miller)
Date: Mon, 30 Nov 2015 14:32:26 -0500 (EST)
Subject: [PATCH 00/13] net: thunderx: HW TSO support and other fixes
In-Reply-To: <1448907549-5296-1-git-send-email-sunil.kovvuri@gmail.com>
References: <y>
	<1448907549-5296-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <20151130.143226.215454553816764730.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sunil.kovvuri@gmail.com>
Date: Mon, 30 Nov 2015 23:48:56 +0530

> This patch series contains fixes for various issues and support for 
> HW TSO which is added in pass2 silicon.

Please do not mix bug fixes and support for new features and cleanups.

First, post a separate series of just the bug fixes, targetting the
'net' tree.

Then once that propagates into 'net-next', you can submit the feature
additions and cleanups relative to that.

Thank you.
