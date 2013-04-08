From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 8 Apr 2013 17:51:37 +0200
Subject: [PATCH v10 02/12] mfd: palmas: is_palmas_charger needed by
 multiple drivers
In-Reply-To: <1363964122-19201-3-git-send-email-ian@slimlogic.co.uk>
References: <1363964122-19201-1-git-send-email-ian@slimlogic.co.uk>
 <1363964122-19201-3-git-send-email-ian@slimlogic.co.uk>
Message-ID: <20130408155137.GY24058@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

On Fri, Mar 22, 2013 at 02:55:12PM +0000, Ian Lartey wrote:
> is_palmas_charger checks for the presence of charging
> functionality in the device
> 
> Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
> Signed-off-by: Ian Lartey <ian@slimlogic.co.uk>
> Acked-by: Laxman Dewangani <ldewangan@nvidia.com>
> ---
>  include/linux/mfd/palmas.h |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
I applied this one now, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
