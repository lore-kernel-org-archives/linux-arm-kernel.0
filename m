From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Nov 2014 09:07:17 +0100
Subject: [PATCH 2/5] ARM: mvebu: enable no-1-8-v flag for Armada 385 DB
 SDHCI interface
In-Reply-To: <1415835600-97188-3-git-send-email-mw@semihalf.com>
References: <1415835600-97188-1-git-send-email-mw@semihalf.com>
 <1415835600-97188-3-git-send-email-mw@semihalf.com>
Message-ID: <20141113090717.5fc5d163@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marcin Wojtas,

On Thu, 13 Nov 2014 00:39:57 +0100, Marcin Wojtas wrote:
> The Marvell Armada 38x SoC's SDHCI interface is capable of using 1.8v voltage,
> needed for driving "UHS-I" SD cards at their full speed. It is not, however,
> possible on the DB board. Due to physical connectivity connector supply is tied
> to 3v and any attempt of changing voltage in order to operate in the fastest UHS
> modes fails.
> 
> This patch enables equivalent SDHCI quirk in order to adjust controller
> operation to system capabilities.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
