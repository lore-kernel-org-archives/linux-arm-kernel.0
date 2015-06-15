From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 15 Jun 2015 10:57:07 +0530
Subject: [PATCH v5 0/7] phy-sun4i-usb: Add OTG and newer SoC support
In-Reply-To: <1434199071-22127-1-git-send-email-hdegoede@redhat.com>
References: <1434199071-22127-1-git-send-email-hdegoede@redhat.com>
Message-ID: <557E622B.50401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Saturday 13 June 2015 06:07 PM, Hans de Goede wrote:
> Hi Kishon,
>
> Here is a patch series with all my oustanding phy-sun4i-usb changes pending
> for merging into 4.3.
>
> This includes the 5th iteration of the OTG support addition, now with the
> extcon provider support addition split-out into a new patch and ported to
> the extcon API changes which are queued up for 4.2 from :
>
> http://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/log/?h=extcon-next-v4.2
>
> which already merged in GKH's char-misc branch for 4.2, this means that
> this series now depends on those changes.
>
> Other than that this is a resend of some of the other feature addition
> patches I recently send rebased on top of v5 of the OTG support.
>
> Please merge this series for 4.3.

sure, will queue once -rc1 is tagged.

Thanks
Kishon
