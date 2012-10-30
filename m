From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Oct 2012 11:48:07 +0100
Subject: [PATCH 1/3] ARM: mvebu: Add support I2C controller
In-Reply-To: <1351593685-19663-1-git-send-email-iwamatsu@nigauri.org>
References: <1351593685-19663-1-git-send-email-iwamatsu@nigauri.org>
Message-ID: <20121030114807.67765823@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Nobuhiro Iwamatsu,

On Tue, 30 Oct 2012 19:41:23 +0900, Nobuhiro Iwamatsu wrote:
> The mvebu arch has the same I2C controller as mv64xxx-i2c.
> This support mv64xxx-i2c on mvebu.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Thanks, looks good to me, but we have to wait for the Armada 370/XP
clock patch set to get merged before merging this.

I'll give it a test on the OpenBlocks hardware and report.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
