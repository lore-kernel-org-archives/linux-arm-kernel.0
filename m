From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 20 May 2015 13:01:39 +0200
Subject: [RESEND PATCH 3.18-stable v2] ARM: mvebu: do not register
 custom DMA operations when coherency is disabled
In-Reply-To: <1432117387-22435-1-git-send-email-bjorn@mork.no>
References: <1432117387-22435-1-git-send-email-bjorn@mork.no>
Message-ID: <20150520130139.5b10083c@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bj?rn Mork,

On Wed, 20 May 2015 12:23:07 +0200, Bj?rn Mork wrote:
> Hello Sasha!
> 
> This backported mvebu fix seems to have slipped through the cracks by
> accident.  IIUC, the OpenWRT mvebu maintainer(s) are particularily
> interested in having this bug fixed for 3.18-stable.  See this thread
> for the original patch submission and discussion:
> http://permalink.gmane.org/gmane.linux.kernel.stable/127243
> 
> I'm including the full patch below for convenicence. It still applies
> to the current 3.18-stable tree (apply with "git am --scissors" if you
> use this email as source).
> 
> I hope Thomas, Imre or Andrew can fill in the details if more
> background info is necessary...

I can confirm that this patch is needed in 3.18-stable.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
