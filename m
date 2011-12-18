From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Dec 2011 23:15:35 +0000
Subject: [PATCH 02/14] mmc: mmci: Fixup handling of MCI_STARTBITERR
In-Reply-To: <1323106560-5218-3-git-send-email-ulf.hansson@stericsson.com>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
 <1323106560-5218-3-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20111218231534.GA14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 06:35:48PM +0100, Ulf Hansson wrote:
> The interrupt was previously enabled and then correctly cleared.
> Now we also handle it correctly.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

I've queued this in my 'fixes' branch with a Cc to the stable team for
previous kernel versions.  I believe that to be appropriate.  Please
confirm.
