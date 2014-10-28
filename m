From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Oct 2014 15:55:34 +0100
Subject: [PATCH RFC v2 2/8] pinctrl: pinconf-generic: Add flag to print
 arguments
In-Reply-To: <1413479495-14206-3-git-send-email-soren.brinkmann@xilinx.com>
References: <1413479495-14206-1-git-send-email-soren.brinkmann@xilinx.com>
 <1413479495-14206-3-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <CACRpkdYDDm1ZL1EVNBzvJaCR7oT-NagJT2bmscMAu=3PJ1pX_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 7:11 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> When dumping pinconf information in debugfs, config arguments are only
> printed when a unit is present and the argument is != 0. For parameters
> like the slew rate, this does not work. The slew rate uses a driver
> specific format for the argument, i.e. 0 can be a valid argument and a
> unit is not provided for it.
> For that reason, add a flag to enable printing the argument instead of
> inferring it from the presence of a unit and the value of the argument.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Patch applied.

Yours,
Linus Walleij
