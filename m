From: kvalo@codeaurora.org (Kalle Valo)
Date: Mon, 20 Mar 2017 16:43:36 +0000 (UTC)
Subject: atmel: remove time_t usage
In-Reply-To: <20170223161445.19200-1-alexandre.belloni@free-electrons.com>
References: <20170223161445.19200-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170320164337.6A21860300@smtp.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> last_qual never really holds a time. It only holds jiffies. Make it the
> same type as jiffies.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Patch applied to wireless-drivers-next.git, thanks.

5c5105666de5 atmel: remove time_t usage

-- 
https://patchwork.kernel.org/patch/9588521/

Documentation about submitting wireless patches and checking status
from patchwork:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
