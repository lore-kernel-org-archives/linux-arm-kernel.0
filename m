From: johan@kernel.org (Johan Hovold)
Date: Mon, 22 Sep 2014 17:17:54 +0200
Subject: [PATCH v5 4/9] rtc: at91sam9: add DT support
In-Reply-To: <1411377058-26155-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1411377058-26155-1-git-send-email-boris.brezillon@free-electrons.com>
 <1411377058-26155-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140922151754.GH5237@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Please don't drop people from CC. ]

On Mon, Sep 22, 2014 at 11:10:53AM +0200, Boris BREZILLON wrote:
> Add of_match_table to the existing driver so that rtc nodes defined in at91
> DTs can be attached to this driver.

That should be rtt nodes.

Johan
