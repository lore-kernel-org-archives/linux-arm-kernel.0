From: joelf@ti.com (Joel Fernandes)
Date: Thu, 10 Apr 2014 11:23:39 -0500
Subject: [PATCH v2 05/14] arm: common: edma: Select event queue 1 as
 default when booted with DT
In-Reply-To: <1396357575-30585-6-git-send-email-peter.ujfalusi@ti.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
 <1396357575-30585-6-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <5346C58B.6050409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/2014 08:06 AM, Peter Ujfalusi wrote:
> Use the EVENTQ_1 for default and leave the EVENTQ_0 to be used by high
> priority channels, like audio.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

This looks good, though another way to do it would be to leave default
to Queue 0. Put audio in Queue 1, and change QUEPRI to make Queue 1 as
higher priority.

This is fine,
Acked-by: Joel Fernandes <joelf@ti.com>

Regards,
-Joel
