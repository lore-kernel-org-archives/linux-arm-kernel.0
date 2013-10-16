From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 16 Oct 2013 11:31:07 -0700
Subject: [PATCH v2 1/3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <20131016180735.GI25034@n2100.arm.linux.org.uk>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <20131003202751.GZ6192@mwanda>
 <20131015131038.GB25034@n2100.arm.linux.org.uk>
 <CAOMZO5BDEFAKue9b94+wCQSk+1V04P9Oz_yrqG5XLZ532L+VUg@mail.gmail.com>
 <20131016170341.GH25034@n2100.arm.linux.org.uk>
 <20131016180735.GI25034@n2100.arm.linux.org.uk>
Message-ID: <20131016183107.GC18050@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 07:07:35PM +0100, Russell King - ARM Linux wrote:
> Sorry, but I don't think imx-drm is driving the hardware correctly, and
> I know that Greg wants it moved out of drivers/staging, but frankly it
> seems to be far from ready for that.  Certainly the HDMI parts seems to
> be especially problematical.

I want it out of staging if it's working properly.  Yours is the first
report of it not working properly, and in fact, probably one of the
first users of the driver, as I haven't gotten any reports of it working
or not at all over the years.

thanks,

greg k-h
