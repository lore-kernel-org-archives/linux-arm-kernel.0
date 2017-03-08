From: kvalo@codeaurora.org (Kalle Valo)
Date: Wed,  8 Mar 2017 15:13:40 +0000 (UTC)
Subject: wireless/atmel: remove time_t usage
In-Reply-To: <20170223161445.19200-1-alexandre.belloni@free-electrons.com>
References: <20170223161445.19200-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170308151340.6E8EF607A1@smtp.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> last_qual never really holds a time. It only holds jiffies. Make it the
> same type as jiffies.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

The title should start with "atmel:", I can fix that during commit.

-- 
https://patchwork.kernel.org/patch/9588521/

Documentation about submitting wireless patches and checking status
from patchwork:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
