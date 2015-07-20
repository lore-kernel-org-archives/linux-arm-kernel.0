From: k.opasiak@samsung.com (Krzysztof Opasiak)
Date: Mon, 20 Jul 2015 16:43:19 +0200
Subject: [PATCH v3 01/46] usb: gadget: encapsulate endpoint claiming
 mechanism
In-Reply-To: <1436941953-1327-2-git-send-email-r.baldyga@samsung.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
 <1436941953-1327-2-git-send-email-r.baldyga@samsung.com>
Message-ID: <55AD0907.8090605@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/15/2015 08:31 AM, Robert Baldyga wrote:
> So far it was necessary for usb functions to set ep->driver_data in
> endpoint obtained from autoconfig to non-null value, to indicate that
> endpoint is claimed by function (in autoconfig it was checked if endpoint
> has set this field to non-null value, and if it has, it was assumed that
> it is claimed). It could cause bugs becouse if some function doesn't

	s/becouse/because

Best regards,
-- 
Krzysztof Opasiak
Samsung R&D Institute Poland
Samsung Electronics
