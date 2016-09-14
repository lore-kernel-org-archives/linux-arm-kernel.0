From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 14 Sep 2016 19:12:02 +0530
Subject: [PATCH] dmaengine: cleanup with list_first_entry_or_null()
In-Reply-To: <1473703697-903-1-git-send-email-yamada.masahiro@socionext.com>
References: <1473703697-903-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160914134202.GK13920@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 03:08:17AM +0900, Masahiro Yamada wrote:
> The combo of list_empty() check and return list_first_entry()
> can be replaced with list_first_entry_or_null().

Applied, thanks

In future please do split this per driver, that helps..

-- 
~Vinod
