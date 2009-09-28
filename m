From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Sep 2009 12:27:15 +0100
Subject: [PATCH] Fix U300 generic GPIO, remove ifdefs from MMCI v2
In-Reply-To: <1254136780-31679-1-git-send-email-linus.walleij@stericsson.com>
References: <1254136780-31679-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20090928112715.GB10671@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 01:19:40PM +0200, Linus Walleij wrote:
> This version is hopefully correct for the API. Sorry for the mess
> again and thanks to Russell and Rabin Vincent for pointing me
> in the right direction on this one.

I feel the comments in the code are too much.  Maybe a single comment
about the return value above the function would be sufficient?
