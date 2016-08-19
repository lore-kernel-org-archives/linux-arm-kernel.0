From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 19 Aug 2016 17:47:48 +0100
Subject: [PATCH 08/13] scpi: add a vendor_msg mechanism in case the
 mailbox message differs
In-Reply-To: <1471515066-3626-9-git-send-email-narmstrong@baylibre.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
 <1471515066-3626-9-git-send-email-narmstrong@baylibre.com>
Message-ID: <bd59fdb1-5f6d-ffba-0c6a-b5eb28397521@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/08/16 11:11, Neil Armstrong wrote:
> In case the mailbox message pointer must contain a specific structure.
> add a mechanism to override the pointer sent to the mailbox by a
> vendor specific data initialized by a vendor speficic function.
>

As discussed, I won't look at this and next patch. You can drop from now.

-- 
Regards,
Sudeep
