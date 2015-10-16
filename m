From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Fri, 16 Oct 2015 13:22:52 +0200
Subject: [PATCH] ARM: at91: pm: at91_pm_suspend_in_sram() must be 8-byte
 aligned
In-Reply-To: <1444991945-7946-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1444991945-7946-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20151016112252.GA17165@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 16, 2015 at 12:39:05PM +0200, Alexandre Belloni wrote:
> From: Patrick Doyle <pdoyle@irobot.com>
> 
> fncpy() requires that the source and the destination are both 8-byte
> aligned.
> 
> Signed-off-by: Patrick Doyle <pdoyle@irobot.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Additional tags:

Fixes: d94e688cae56 ("ARM: at91/pm: move the copying the sram function to the sram initialization phase")
Cc: <stable@vger.kernel.org> # 4.1+

Sylvain
