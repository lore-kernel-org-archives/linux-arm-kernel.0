From: nm@ti.com (Nishanth Menon)
Date: Tue, 29 Jan 2013 10:02:44 -0600
Subject: [RFC PATCH 0/2] ARM: update cpuinfo to print CPU model name
In-Reply-To: <1359474865-15408-1-git-send-email-ruslan.bilovol@ti.com>
References: <1359474865-15408-1-git-send-email-ruslan.bilovol@ti.com>
Message-ID: <20130129160243.GA3389@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:54-20130129, Ruslan Bilovol wrote:
> Hi,
> 
> The following patches update cpuinfo to print CPU
> model name for ARM. First patch exactly makes needed
> changes for ARM architecture.
> Second patch adds this ability to OMAP4 SoCs.
> 
> This adds a common approach to show SoC name.
> 
> Looks like there were few attempts to do similar
> changes to cpuinfo without any luck.
> 
> So - comments are welcome
> 
> Ruslan Bilovol (2):
>   ARM: kernel: update cpuinfo to print CPU model name
>   ARM: OMAP4: setup CPU model name during ID initialisation

We had an discussion on similar lines but a generic suggestion:
https://patchwork.kernel.org/patch/98720/
SoCinfo framework which was supposed to introduce this

Would'nt that be a better approach to take than an OMAP only solution?

Ccying eduardo who had driven this for some time.
-- 
Regards,
Nishanth Menon
