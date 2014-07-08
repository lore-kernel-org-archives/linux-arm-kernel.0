From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 8 Jul 2014 11:16:47 +0300
Subject: [PATCH] clk: tegra: Use XUSB-compatible SATA PLL sequence
In-Reply-To: <1404804615-23587-1-git-send-email-mperttunen@nvidia.com>
References: <CAL1qeaHo_HEoXoCQjQuqux_BNPtz4BtOnrYTa4=vcNQCYxiDSg@mail.gmail.com>
 <1404804615-23587-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <20140708081647.GV3679@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 09:30:15AM +0200, Mikko Perttunen wrote:
> Use a sequence for enabling hardware control of the SATA PLL
> that works both when using the SATA lane with SATA and when
> using it with XUSB.
> 

I'm going to take it as a separate patch on top of what's there now.

Cheers,

Peter.
