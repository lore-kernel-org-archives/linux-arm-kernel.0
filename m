From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 2 Apr 2013 14:03:34 +0530
Subject: [PATCH v3 3/3] ARM: davinci: da850: add EHRPWM & ECAP DT node
In-Reply-To: <1364197789-16783-4-git-send-email-avinashphilip@ti.com>
References: <1364197789-16783-1-git-send-email-avinashphilip@ti.com>
 <1364197789-16783-4-git-send-email-avinashphilip@ti.com>
Message-ID: <515A97DE.1080403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/25/2013 1:19 PM, Philip Avinash wrote:
> Add da850 EHRPWM & ECAP DT node.
> Also adds OF_DEV_AUXDATA for EHRPWM & ECAP driver to use EHRPWM & ECAP
> clock.

This looks fine to me but I will wait for the bindings to get accepted
before taking this one.

Thanks,
Sekhar
