From: anton@enomsg.org (Anton Vorontsov)
Date: Tue, 22 Oct 2013 14:03:38 -0700
Subject: [PATCH 2/4] power: isp1704_charger: Fix driver to work with
 changes introduced in v3.5
In-Reply-To: <1378630239-10006-3-git-send-email-pali.rohar@gmail.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1378630239-10006-3-git-send-email-pali.rohar@gmail.com>
Message-ID: <20131022210337.GA6148@teo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 08, 2013 at 10:50:37AM +0200, Pali Roh?r wrote:
> * omap musb driver does not report USB_EVENT_ENUMERATED event anymore
> * omap musb driver reporting USB_EVENT_VBUS when charger is connected
> * read last event from phy->last_event (instead from ulpi register)
> * do not call wall charger detection more times
> 
> Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>

Applied, thanks a lot!

(Per others' review comments I am assuming that the second isp1704 patch
will be reworked to support device-tree, so I am not applying it.)

Thanks,

Anton
