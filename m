From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 23 Apr 2015 14:16:12 -0700
Subject: [RFC/RFT 5/6] i2c: qup: Get rid of clock handling as its done
 using runtime callbacks
In-Reply-To: <1429778744-13352-6-git-send-email-rnayak@codeaurora.org>
 (Rajendra Nayak's message of "Thu, 23 Apr 2015 14:15:43 +0530")
References: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>
 <1429778744-13352-6-git-send-email-rnayak@codeaurora.org>
Message-ID: <7hoame5yw3.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rajendra Nayak <rnayak@codeaurora.org> writes:

> Remove all clock handling from the driver as this is not handled from
> within platform runtime callbacks.

s/not/now/  ??

Kevin
