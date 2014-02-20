From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 20 Feb 2014 10:18:45 +0100
Subject: [PATCH v7 0/4] DT support for kirkwood based Synology NAS boxes
In-Reply-To: <1392840157-31072-1-git-send-email-klightspeed@killerwolves.net>
References: <1392840157-31072-1-git-send-email-klightspeed@killerwolves.net>
Message-ID: <20140220091845.GH11878@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 06:02:33AM +1000, klightspeed at killerwolves.net wrote:
> This patchset adds support for around 30 kirkwood bases Synology NAS
> boxes. Patch #1 documents vendor prefixes. Patch #2 generalizes the qnap
> power off driver so that it can also be used for Synology devices.
> Patch #3 adds sii,s35390a to i2c trivial devices. Patch #4 adds the 
> synology DT files.

Hi Ben

Thanks for finishing this.

Whole series:

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew
