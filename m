From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 28 May 2014 11:53:34 -0700
Subject: [PATCH v3 1/5] sc_phy:SmartCard(SC) PHY interface to SC controller
In-Reply-To: <1401267437-22489-2-git-send-email-satish.patel@ti.com>
References: <1401267437-22489-1-git-send-email-satish.patel@ti.com>
 <1401267437-22489-2-git-send-email-satish.patel@ti.com>
Message-ID: <20140528185334.GA30763@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 02:27:13PM +0530, Satish Patel wrote:
> SmartCard controller uses this interface to communicate with
> SmartCard via PHY
> 
> Some SmartCard PHY has multiple slots for cards.
> This inerface also enables controller to communicate
> with one or more SmartCard connected over phy.
> 
> interface structure includes following APIs
> - set/get config
> - activate/deactivate smart card
> - warm reset
> - register_notify (for card insert/remove/overheat)
> - unregister_notify
> 
> Signed-off-by: Satish Patel <satish.patel@ti.com>
> ---
>  Documentation/sc_phy.txt |  171 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/sc_phy.h   |  136 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 307 insertions(+)
>  create mode 100644 Documentation/sc_phy.txt
>  create mode 100644 include/linux/sc_phy.h

These are .h files, but where is the "api" functions that use
these structures defined at?

confused,

greg k-h
