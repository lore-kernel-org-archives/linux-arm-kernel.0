From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Aug 2012 06:31:35 +0800
Subject: [PATCH 0/2] tty: serial: imx: fix lockup and garbage on SMP
In-Reply-To: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com>
References: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20120827223134.GD2281@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 09:36:50AM +0200, Dirk Behme wrote:
> Both issues are gone applying these two patches.
> 
> Note: If these patches are fine, they should go to stable, too.
> 
Then you should have Cc: <stable@vger.kernel.org> tag on these patches.

-- 
Regards,
Shawn
