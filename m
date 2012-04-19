From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 18 Apr 2012 17:08:42 -0700
Subject: [PATCH v2 0/9] PM: Create the AVS class of drivers
In-Reply-To: <CAORVsuV-GJAabY49G0fOgcBcg-CNdpNiTE+AcBN07wrWZH3qcQ@mail.gmail.com>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
 <CAORVsuV-GJAabY49G0fOgcBcg-CNdpNiTE+AcBN07wrWZH3qcQ@mail.gmail.com>
Message-ID: <20120419000842.GA24575@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 10:04:22AM +0200, Jean Pihet wrote:
> Hi Andrew, Greg,
> 
> Can you please look at this patch set?
> The idea is to create a framework and drivers for the AVS class of
> devices. This patch set implements the first step by moving the
> existing code to drivers/power/avs. Next steps will be to implement
> class support and notifications, add more classes of operations for
> OMAP chips, etc.
> 
> Keerthy J is taking over the ownership of this code and will continue
> the development further.
> 
> What do you think?

I think Kevin and Rafael's comments need to be addressed.

greg k-h
