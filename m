From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 7 Jul 2015 18:03:20 +0300
Subject: [PATCH 4/5] staging: emxx_udc: add missing
 usb_ep_set_maxpacket_limit()
In-Reply-To: <1436277773-14274-5-git-send-email-r.baldyga@samsung.com>
References: <1436277773-14274-1-git-send-email-r.baldyga@samsung.com>
 <1436277773-14274-5-git-send-email-r.baldyga@samsung.com>
Message-ID: <20150707150320.GF4341@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 04:02:52PM +0200, Robert Baldyga wrote:
> Should use usb_ep_set_maxpacket_limit instead of setting
> maxpacket value manually.
> 

Same question.

regards,
dan carpenter
