From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 16 Dec 2011 01:38:54 -0700 (MST)
Subject: [PATCHv8 3/5] OMAP: I2C: Reset support
In-Reply-To: <1323773758-6375-4-git-send-email-shubhrajyoti@ti.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com>
 <1323773758-6375-4-git-send-email-shubhrajyoti@ti.com>
Message-ID: <alpine.DEB.2.00.1112160138310.12660@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Dec 2011, Shubhrajyoti D wrote:

> Under some error conditions the i2c driver may do a reset.
> Adding a reset field and support in the device-specific code to aid
> error-recovery.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Thanks, queued for 3.3.


- Paul
