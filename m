From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 25 Oct 2018 21:26:21 +0200
Subject: [PATCH v2] ARM: mm: Facilitate debugging CONFIG_KUSER_HELPERS
 disabled
In-Reply-To: <20181025190110.7564-1-f.fainelli@gmail.com>
References: <20181025190110.7564-1-f.fainelli@gmail.com>
Message-ID: <20181025192621.GB16785@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 12:01:08PM -0700, Florian Fainelli wrote:
> Some software such as perf makes unconditional use of the special
> [vectors] page which is only provided when CONFIG_KUSER_HELPERS is
> enabled in the kernel.
> 
> Facilitate the debugging of such situations by printing a debug message
> to the kernel log showing the task name and the faulting address.

Hi Florian

Nice. I wish we had this a couple of months ago.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks
    Andrew
