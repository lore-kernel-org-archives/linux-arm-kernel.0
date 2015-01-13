From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 12 Jan 2015 20:04:41 -0800
Subject: [PATCH v3 11/13] mtd: st_spi_fsm: General tidy-up
In-Reply-To: <1418644760-18773-12-git-send-email-lee.jones@linaro.org>
References: <1418644760-18773-1-git-send-email-lee.jones@linaro.org>
 <1418644760-18773-12-git-send-email-lee.jones@linaro.org>
Message-ID: <20150113040441.GL9759@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 11:59:18AM +0000, Lee Jones wrote:
> Due to the nature of the port (lots of copy/paste) much of the white-space
> is taken up by spaces instead of tab separators. This patch aims to change
> that.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

checkpatch.pl gives several warnings like this on this patch:

    WARNING:SPACE_BEFORE_TAB: please, no space before tabs

Please consider fixing them up.

Brian
