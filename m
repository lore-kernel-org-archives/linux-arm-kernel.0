From: greg@kroah.com (Greg KH)
Date: Thu, 5 Jul 2018 19:05:49 +0200
Subject: [PATCH] ARM64: dts: meson-gxl-s905x-p212: Add phy-supply for usb0
In-Reply-To: <817c589d-25e4-e2d0-cd46-99a2ae59b014@baylibre.com>
References: <1528188743-12798-1-git-send-email-narmstrong@baylibre.com>
 <817c589d-25e4-e2d0-cd46-99a2ae59b014@baylibre.com>
Message-ID: <20180705170549.GF4349@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 10:43:19AM +0200, Neil Armstrong wrote:
> Hi Stable Maintainers,
> 
> On 05/06/2018 10:52, Neil Armstrong wrote:
> > Like LibreTech-CC, the USB0 needs the 5V regulator to be enabled to power the
> > devices on the P212 Reference Design based boards.
> > 
> > Fixes: b9f07cb4f41f ("ARM64: dts: meson-gxl-s905x-p212: enable the USB controller")
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> 
> This commit hit Linus master with commit sha d511b3e4087eedbe11c7496c396432b8b7c2d7d9
> Can this fix be applied to 4.17 stable kernel ?

Now applied, thanks.

greg k-h
