From: briannorris@chromium.org (Brian Norris)
Date: Fri, 3 Jun 2016 13:07:46 -0700
Subject: [PATCH 04/14] pwm: rockchip: Add support for hardware readout
In-Reply-To: <1464942192-25967-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464942192-25967-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160603200746.GB124478@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 10:23:02AM +0200, Boris Brezillon wrote:
> Implement the ->get_state() function to expose initial state.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/pwm-rockchip.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)

[...]

Tested-by: Brian Norris <briannorris@chromium.org>
