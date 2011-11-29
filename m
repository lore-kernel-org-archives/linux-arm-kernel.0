From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 29 Nov 2011 13:55:20 +0530
Subject: [PATCH 2/5] regulator: fix label names used in device tree
 bindings
In-Reply-To: <1322487439-27254-3-git-send-email-shawn.guo@linaro.org>
References: <1322487439-27254-1-git-send-email-shawn.guo@linaro.org>
 <1322487439-27254-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <4ED496F0.3040603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 November 2011 07:07 PM, Shawn Guo wrote:
> Device tree compiler does not recognize '-' in label name.  Instead,
> '_' works fine.

Thanks, that does seem to be the case. I figured it myself when I added
them in actual .dts files but missed updating the bindings.
