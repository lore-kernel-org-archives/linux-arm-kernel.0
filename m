From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 22 Apr 2016 12:05:18 -0700
Subject: [PATCH v2 1/1] arm64: dts: NS2 secondary core enablement via PSCI
In-Reply-To: <1461174002-18178-1-git-send-email-luke.starrett@broadcom.com>
References: <1461174002-18178-1-git-send-email-luke.starrett@broadcom.com>
Message-ID: <571A75EE.6030203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/04/16 10:40, Luke Starrett wrote:
> Declare PSCI-1.0 node and enable CPU_ON method via PSCI.  Spin-table
> memreserve has been removed as well as syscon based reset, as PSCI-1.0
> expects reset implementation in firmware.
> 
> Signed-off-by: Luke Starrett <luke.starrett@broadcom.com>

Applied with Scott's Ack, thanks Luke!
-- 
Florian
