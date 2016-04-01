From: k.debski@samsung.com (Kamil Debski)
Date: Fri, 01 Apr 2016 10:29:55 +0200
Subject: [PATCH v5 35/46] hwmon: pwm-fan: switch to the atomic API
In-Reply-To: <1459368249-13241-36-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-36-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <00e601d18bf0$acd69150$0683b3f0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

From: Boris Brezillon [mailto:boris.brezillon at free-electrons.com]
Sent: Wednesday, March 30, 2016 10:04 PM
Subject: [PATCH v5 35/46] hwmon: pwm-fan: switch to the atomic API
> 
> pwm_config/enable/disable() have been deprecated and should be replaced
> by pwm_apply_state().
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Kamil Debski <k.debski@samsung.com>

Best wishes,
-- 
Kamil Debski
Samsung R&D Institute Poland
