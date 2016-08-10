From: robh@kernel.org (Rob Herring)
Date: Wed, 10 Aug 2016 13:44:51 -0500
Subject: [PATCH RFC 1/3] DT: bindings: mmc: Add property for 3.3V only
 support
In-Reply-To: <1470488140-10104-2-git-send-email-stefan.wahren@i2se.com>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
 <1470488140-10104-2-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20160810184451.GA13473@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 06, 2016 at 12:55:38PM +0000, Stefan Wahren wrote:
> Currently there is no proper way to define that a MMC host supports
> only 3.3V. The property no-1-8-v is broken and has different meanings
> for different sdhci variants. So add a new property for 3.3V only
> support and mark no-1-8-v as deprecated.

Why is it broken? How would I override a controller saying 1.8V is 
supported and it is not?

Rob
