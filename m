From: johan@kernel.org (Johan Hovold)
Date: Thu, 11 Sep 2014 11:39:42 +0200
Subject: [PATCH v3 0/8] rtc: at91sam9: add DT support
In-Reply-To: <1410425767-17874-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1410425767-17874-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140911093942.GA12295@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 10:55:59AM +0200, Boris BREZILLON wrote:

> Johan, let me know if this version addresses part of your concerns.

Looks good to me. I just have a few minor comments on two of the patches.

> I'm open to any suggestion/rework to address other previously discussed
> issues, as long as it does not end up in a dead-end (like the discussion
> you had last year):
>  - the fact that the RTT block could be used for something that is not
>    an RTC
>  - the fact that referencing the GPBR node and defining a GPBR register
>    number to store RTC time info could be considered as an HW config and
>    not an HW description and thus should not be described in the DT

No doubt.

>  - other things I don't remember :-)

Thanks,
Johan
