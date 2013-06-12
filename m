From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 12 Jun 2013 12:52:23 +0200
Subject: [RFC PATCH 30/50] pwm: atmel-tcb: prepare clk before calling
 enable
In-Reply-To: <1370622402-19693-1-git-send-email-b.brezillon@overkiz.com>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
 <1370622402-19693-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20130612105222.GB1940@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 06:26:42PM +0200, Boris BREZILLON wrote:
> Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
> avoid common clk framework warnings.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> ---
>  drivers/pwm/pwm-atmel-tcb.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130612/ec99b2b3/attachment.sig>
