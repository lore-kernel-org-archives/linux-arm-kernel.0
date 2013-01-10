From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 9 Jan 2013 20:32:05 -0500
Subject: [PATCH] ARM: Kirkwood: convert ns2 boards to pinctrl
In-Reply-To: <1357655778-32066-1-git-send-email-simon.guinot@sequanux.org>
References: <1357655778-32066-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20130110013205.GA5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 03:36:18PM +0100, Simon Guinot wrote:
> Note that the pinctrl conversion also fixes GPIO support for ns2 boards.
> Since commit f9e75922: "ARM: Kirkwood: Make use of mvebu pincltl and
> gpio", the mvbu_gpio driver is used for DT boards. As mvbu_gpio relies
> on the pinctrl driver, then a pinctrl definition must be given to allow
> the GPIO configuration.
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>

Applied to mvebu/fixes with the following subject:

    ARM: Kirkwood: fix ns2 gpios by converting to pinctrl

thx,

Jason.
