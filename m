From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 26 Jun 2015 09:42:41 -0700
Subject: [PATCH] ARM: dts: sunxi: Adjust touchscreen compatible for sun5i
 and later
In-Reply-To: <1435322859-27760-1-git-send-email-hdegoede@redhat.com>
References: <1435322859-27760-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150626164241.GD13320@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 26, 2015 at 02:47:39PM +0200, Hans de Goede wrote:
> This is a manual cherry pick of a commit currently queued up for merging
> into 4.2, titled:
> "ARM: dts: sunxi Adjust touchscreen compatible for sun5i and later"
> 
> For the 4.1 stable series, fixing a regression in 4.1 where we are now
> reporting the wrong SoC temperature for sun5i and sun7i SoCs.

What is the git commit id of it?  I can't do anything with this until it
hits Linus's tree.

thanks,

greg k-h
