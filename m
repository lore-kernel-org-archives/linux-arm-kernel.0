From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 13 Sep 2018 11:10:20 -0700
Subject: [PATCH v3 0/3] ARM: NSP updates to support switch interrupts/SFP
In-Reply-To: <20180831192039.11842-1-f.fainelli@gmail.com>
References: <20180831192039.11842-1-f.fainelli@gmail.com>
Message-ID: <5751f9e2-6056-37cc-4749-cb8509b56916@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/31/18 12:20, Florian Fainelli wrote:
> Hi all,
> 
> This patch series updates the ARM NSP DTS and BCM958625HR in order to
> support the SFP connected to port 5 on these reference boards.
> 
> I will be submitting the functional changes to drivers/net/dsa/b53 once
> net-next opens back up, but this is largely independent from getting
> these 3 patches out.

Series applied to devicetree/next.
-- 
Florian
