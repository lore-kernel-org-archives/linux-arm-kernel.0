From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 12 Mar 2018 15:51:01 -0700
Subject: [PATCH] ARM: dts: NSP: Switch to port 8 for CPU port
In-Reply-To: <20180227204520.24122-1-f.fainelli@gmail.com>
References: <20180227204520.24122-1-f.fainelli@gmail.com>
Message-ID: <20180312225101.14635-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Feb 2018 12:45:19 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Now that we have added support for pre-pended Broadcom tags with commit
> 11606039604c ("net: dsa: b53: Support prepended Broadcom tags") we can
> switch all the Northstar Plus reference boards to use port 8 for the CPU
> port. This allows us to prepare room for supporting the Flow Accelerator
> 2 NAPT offload, and frees up port 5 to be made fully configurable for
> the modes that it supports: internal, SGMII, RGMII etc.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
