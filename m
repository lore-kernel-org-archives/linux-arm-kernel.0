From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Aug 2012 07:37:59 +0800
Subject: [PATCH 0/2] tty: serial: imx: fix lockup and garbage on SMP
In-Reply-To: <20120827225142.GA11302@kroah.com>
References: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com>
 <20120827223134.GD2281@r65073-Latitude-D630>
 <20120827225142.GA11302@kroah.com>
Message-ID: <20120827233756.GH2281@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 03:51:42PM -0700, Greg Kroah-Hartman wrote:
> On both of them?  I can do that if needed.  How far back should they go?
> 
It should be okay to apply on 3.4 and 3.5.  But patch #2 is still in
question.  I do not like the #ifdef.

-- 
Regards,
Shawn
