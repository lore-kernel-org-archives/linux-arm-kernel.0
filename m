From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 20 Nov 2012 18:32:54 +0530
Subject: [PATCH] video: da8xx-fb: clk_get on connection id fck
In-Reply-To: <1353415261-30080-1-git-send-email-prakash.pm@ti.com>
References: <1353415261-30080-1-git-send-email-prakash.pm@ti.com>
Message-ID: <50AB7F7E.1070400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 6:11 PM, Manjunathappa wrote:
> do clk_get on connection id "fck" to support OMAP based
> platforms having multiple clocks for module. Without this
> driver change clk_get fails on am335x.
> 
> This patch is based on the discussion in community
> http://marc.info/?l=linux-kernel&m=135166018907827&w=2
> 
> Signed-off-by: Manjunathappa <prakash.pm@ti.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>

For the mach-davinci changes:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Florian,

I assume you will want to take this through your tree?

Thanks,
Sekhar
