From: davidb@codeaurora.org (David Brown)
Date: Wed, 19 Jan 2011 14:40:40 -0800
Subject: [PATCH v2 00/11] msm: Add initial support for MSM8960
In-Reply-To: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <8ya1v48o6tz.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resending with CC's actually present in the header.

This series adds initial support for the MSM8960.  Unfortunately, the
naming of this device is misleading, and it is not a particular
instance of the current MSM8x60 devices, but a rather different chip.
The MSM8x60 arch supports the 8260 and 8660 devices.  I may make a
future patch to rename this arch to be one of these names.

Patch versions:
v2 - Remove ifdefs for io mappings for the new target.  More need to
     be cleaned up for all targets, but this doesn't add new ones.
     The irq table still contains an ifdef, which will be cleaned up
     in an upcoming patch.

--
To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
