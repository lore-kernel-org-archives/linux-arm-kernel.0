From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  4 Jun 2018 14:15:26 -0700
Subject: [PATCH 1/2] soc: bcm: brcmstb: pm: Add support for newer rev B3.0
 controllers
In-Reply-To: <20180511220242.837-2-f.fainelli@gmail.com>
References: <20180511220242.837-1-f.fainelli@gmail.com>
 <20180511220242.837-2-f.fainelli@gmail.com>
Message-ID: <20180604211526.21230-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 May 2018 15:02:41 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> Update the Device Tree binding document and add a matching entry for the
> MEMC DDR controller revision B3.0 which is found on chips like 7278A0
> and newer.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> [florian: tweak commit message, make it apply to upstream kernel]
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to drivers/next, thanks!
--
Florian
