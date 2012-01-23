From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Jan 2012 10:42:20 +0000
Subject: [PATCH v2] spi: QUP based bus driver for Qualcomm MSM chipsets
In-Reply-To: <1321307907-31508-1-git-send-email-harinij@codeaurora.org>
References: <y> <1321307907-31508-1-git-send-email-harinij@codeaurora.org>
Message-ID: <20120123104220.GV1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not specific to this patch, but I notice that you have in your headers:

In-Reply-To: <y>
References: <y>

This is rather annoying, because it means that anyone else who has the
same lines ends up having their messages attached to your messages as
part of the same thread.

I think you need to read the documentation for git-send-email again -
and check that you're using the arguments concerning message ids and
threading correctly.

Thanks.
