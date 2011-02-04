From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 04 Feb 2011 16:31:40 +0300
Subject: [PATCH] arm: mach-omap2: board-rm680: fix rm680_vemmc regulator
	constraints
In-Reply-To: <1296574588-23588-1-git-send-email-aaro.koskinen@nokia.com>
References: <1296574588-23588-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <4D4BFFBC.4040606@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-02-2011 18:36, Aaro Koskinen wrote:

> With the commit 757902513019e6ee469791ff76f954b19ca8d036 fixed voltage

    Please also specify the commit summary in parens, as asked by Linus.

> regulator setup will fail if there are voltage constraints defined. This
> made MMC unusable on this board. Fix by just deleting those redundant
> constraints.

> Signed-off-by: Aaro Koskinen<aaro.koskinen@nokia.com>

WBR, Sergei
