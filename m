From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Oct 2015 16:30:15 +0200
Subject: [PATCH v7 2/5] pwm: add the Berlin pwm controller driver
In-Reply-To: <1443797990-10809-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1443797990-10809-1-git-send-email-antoine.tenart@free-electrons.com>
 <1443797990-10809-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20151005143015.GB27759@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 04:59:47PM +0200, Antoine Tenart wrote:
> Add a PWM controller driver for the Marvell Berlin SoCs. This PWM
> controller has 4 channels.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>  drivers/pwm/Kconfig      |   9 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-berlin.c | 221 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 231 insertions(+)
>  create mode 100644 drivers/pwm/pwm-berlin.c

Applied, with minor tweaks, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/2457e4a4/attachment.sig>
