From: hias@horus.com (Matthias Reichl)
Date: Tue, 21 Nov 2017 21:38:42 +0100
Subject: [PATCH RFC] ARM: dts: bcm283x: Fix probing of bcm2835-i2s
In-Reply-To: <1511110827-2726-1-git-send-email-stefan.wahren@i2se.com>
References: <1511110827-2726-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20171121203842.z274detdxg3hgotq@camel2.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 19, 2017 at 06:00:27PM +0100, Stefan Wahren wrote:
> Since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
> the bcm2835-i2s requires a clock as DT property. Unfortunately
> the necessary DT change has never been applied. While we are at it
> also fix the first PCM register range to cover the PCM_GRAY register.
> 
> This patch also fixes the dt-bindings accordlingly.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Tested-by: Matthias Reichl <hias@horus.com>
