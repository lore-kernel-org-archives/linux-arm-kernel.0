From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 18 Aug 2016 16:53:20 +0100
Subject: [PATCH 01/13] scpi: Add vendor_send_message to enable access to
 vendor commands
In-Reply-To: <1471515066-3626-2-git-send-email-narmstrong@baylibre.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
 <1471515066-3626-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <c5b2d698-de4c-012a-7e7b-63685b7e898c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/08/16 11:10, Neil Armstrong wrote:
> Adds an optional vendor_send_message to the scpi to enable sending
> vendor platform specific commands to the SCP firmware.
>

I don't see any users of vendor_send_message in this series, so I prefer
it to be dropped and introduced when required.

Also I had a different view on how to introduce this[1]. I would rather
wait until the requirement comes that enables us to make use of it.
Looks like you took parts of it and introduces vendor_send_message
allowing users to send any data which I don't like especially without
knowing how will it be (ab)used.

-- 
Regards,
Sudeep

[1] http://www.spinics.net/lists/kernel/msg2263649.html
