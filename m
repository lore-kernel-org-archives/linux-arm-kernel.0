From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 15 Sep 2016 21:41:47 +0200
Subject: [PATCH 0/2] i2c: meson: add gxbb compatible string
In-Reply-To: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
References: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <20160915194146.GB7863@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 11:49:15AM +0200, Jerome Brunet wrote:
> This patchset adds a specific compatible string in the Meson I2C driver
> for the Amlogic Meson gxbb SoC.
> 
> Other patch series (pinctrl and device tree) are being sent to complete
> the i2c support on meson gxbb
> 
> Neil Armstrong (2):
>   i2c: meson: add gxbb compatible string
>   dt-bindings: i2c-meson: add gxbb compatible string

Squashed both patches and applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160915/7caf8a41/attachment.sig>
