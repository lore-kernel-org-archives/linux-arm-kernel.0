From: olof@lixom.net (Olof Johansson)
Date: Fri, 17 Jul 2015 09:54:35 -0700
Subject: [PATCH 00/17] LPC18xx DTS changes for 4.3
In-Reply-To: <1436881192-23930-1-git-send-email-manabian@gmail.com>
References: <1436881192-23930-1-git-send-email-manabian@gmail.com>
Message-ID: <20150717165435.GB21691@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joachim,

On Tue, Jul 14, 2015 at 03:39:35PM +0200, Joachim Eastwood wrote:
> This patch set adds DT nodes for all the drivers that went upstream
> in 4.2 and should represent the bulk of DTS changes for 4.3.  All
> nodes added are documented and some of patches carries a ack from
> subsystem maintainer. It also features updates to the EA4357 dev-
> kit and a new board from Ezequiel Garcia.
> 
> Note that there might be one more batch of DTS changes for 4.3 if
> any new drivers goes upstream and also some changes for the Hitex
> eval board might come.
> 
> Patches also available on:
> https://github.com/manabian/linux-lpc.git lpc18xx_43xx_dts_4.3

The patchset looks good. I've merged the branch with the description
above.

In the future, please feel free to start using a signed tag even
if your key might not be signed by others yet, and over time collect
signatures from other developers. That way we get the merge description
automatically when we pull the tag.


Thanks,

-Olof
