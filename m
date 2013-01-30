From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 30 Jan 2013 09:14:53 +0100
Subject: [PATCH v3 1/3] pwm: Add pwm_can_sleep() as exported API to users
In-Reply-To: <1359381659-24454-2-git-send-email-florian.vaussard@epfl.ch>
References: <1359381659-24454-1-git-send-email-florian.vaussard@epfl.ch>
 <1359381659-24454-2-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <20130130081453.GA13568@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 03:00:57PM +0100, Florian Vaussard wrote:
> Calls to some external PWM chips can sleep. To help users,
> add pwm_can_sleep() API.
> 
> Cc: Thierry Reding <thierry.reding@avionic-design.de>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  drivers/pwm/core.c  |   12 ++++++++++++
>  include/linux/pwm.h |   10 ++++++++++
>  2 files changed, 22 insertions(+), 0 deletions(-)

Applied (with a minor fixup to the kerneldoc comment), thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130130/ea77a483/attachment.sig>
