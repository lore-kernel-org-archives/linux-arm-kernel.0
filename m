From: briannorris@chromium.org (Brian Norris)
Date: Fri, 3 Jun 2016 13:37:51 -0700
Subject: [PATCH 06/14] pwm: rockchip: Add support for atomic update
In-Reply-To: <1464942192-25967-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464942192-25967-7-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160603203751.GE124478@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 10:23:04AM +0200, Boris Brezillon wrote:
> Implement the ->apply() function to add support for atomic update.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/pwm/pwm-rockchip.c | 84 ++++++++++++++++++++++++----------------------
>  1 file changed, 43 insertions(+), 41 deletions(-)

[...]

Looks good to me:

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>
