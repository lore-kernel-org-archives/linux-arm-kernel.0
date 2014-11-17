From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 17 Nov 2014 12:01:23 +0100
Subject: [PATCH v10 0/2] pwm: add support for atmel-hlcdc-pwm device
In-Reply-To: <1412689095-14259-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1412689095-14259-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141117110122.GA25699@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 03:38:13PM +0200, Boris Brezillon wrote:
> Hi Thierry,
> 
> This patch series adds support for the atmel-hlcdc-pwm device provided
> by the atmel-hlcdc MFD driver.
> 
> Best Regards,
> 
> Boris
> 
> Changes since v9:
>  - replace select by depends on
>  - rework commit messages
>  - rework Kconfig description
> 
> Changes since v8:
>  - rework the enable/disable waiting loop
>  - check return code of regmap functions
>  - fix DT binding doc
> 
> Changes since v7:
>  - addressed several coding style issues
> 
> 
> Boris Brezillon (2):
>   pwm: add support for atmel-hlcdc-pwm device
>   pwm: add DT bindings documentation for atmel-hlcdc-pwm driver
> 
>  .../devicetree/bindings/pwm/atmel-hlcdc-pwm.txt    |  29 +++
>  drivers/pwm/Kconfig                                |  11 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-atmel-hlcdc.c                      | 259 +++++++++++++++++++++
>  4 files changed, 300 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
>  create mode 100644 drivers/pwm/pwm-atmel-hlcdc.c

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/fc5caccc/attachment-0001.sig>
