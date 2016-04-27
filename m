From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 27 Apr 2016 19:09:57 +0530
Subject: [PATCH 0/2] da8xx clocks (was part of "da8xx USB clocks")
In-Reply-To: <1460661217-7389-1-git-send-email-david@lechnology.com>
References: <1460661217-7389-1-git-send-email-david@lechnology.com>
Message-ID: <5720C12D.9030708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 April 2016 12:43 AM, David Lechner wrote:
> I have separated these patches from the "da8xx USB clocks" series since that
> series no longer depends on the clock init being moved.
> 
> Tested working on the linux-davinci/master branch with LEGO MINDSTORMS EV3.
> 
> David Lechner (2):
>   ARM: davinci: Move clock init after ioremap.
>   ARM: davinci: da850: use clk->set_parent for async3

Applied these two.

Regards,
Sekhar
