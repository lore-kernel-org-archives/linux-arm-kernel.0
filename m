From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 4 Dec 2017 08:58:14 -0600
Subject: [PATCH v4] usb: xhci: allow imod-interval to be configurable
In-Reply-To: <1512397671-28733-1-git-send-email-awallis@codeaurora.org>
References: <1512397671-28733-1-git-send-email-awallis@codeaurora.org>
Message-ID: <9cb2e5fc-1bec-c19c-c04e-fe56e5c1bc16@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/4/17 8:27 AM, Adam Wallis wrote:
> If no interval is specified, the default of 40,000ns (IMOD=160) will be
> used.

...

> + - imod-interval-ns: default interrupt moderation interval is 5000ns

...

> +  - imod-interval-ns: default interrupt moderation interval is 5000ns

...

> +	xhci->imod_interval = 5000;

...

> +	xhci->imod_interval = 40000;

...

> +	xhci->imod_interval = 40000;

Is the default 5,000 or 40,000?  I can't tell.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
