From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Sat, 03 Oct 2015 14:33:50 +0200
Subject: [PATCH v4 10/26] ARM: pxa: magician: Optimize Samsung LCD
 refresh to 50Hz
In-Reply-To: <5609B1DC.2040703@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609B1DC.2040703@tul.cz>
Message-ID: <1443875630.4186.23.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 28.09.2015, 23:32 +0200 schrieb Petr Cvek:
> Change the default Samsung LCD refresh from an unrealistic 117Hz to
> 50Hz
> as no video applications on the HTC Magician can work that fast.
> 
> The optimalization lowers the RAM latency at least by 3%.
> 
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>

Acked-by: Philipp Zabel <philipp.zabel@gmail.com>
