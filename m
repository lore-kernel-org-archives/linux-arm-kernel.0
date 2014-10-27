From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 27 Oct 2014 18:34:21 +0100
Subject: [PATCH 0/4] Touchscreen performance related fixes
In-Reply-To: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
Message-ID: <544E821D.5040004@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 12:08 PM, Vignesh R wrote:
> This series of patches fix TSC defects related to lag in touchscreen

I will try to look this in the next few days. Do we really need #3 (and
then #4)? Given the complexity we have already, is there any benefit by
decreasing this value? Would  someone want to increase it? Can we safely
determine a value which works for everyone?

Sebastian
