From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 13 Dec 2010 11:15:25 +0000
Subject: [PATCH] ARM: mmp: added 5V Regulator enable for Brownstone
In-Reply-To: <1292185730-3015-1-git-send-email-mark.brown314@gmail.com>
References: <1292185730-3015-1-git-send-email-mark.brown314@gmail.com>
Message-ID: <20101213111524.GA4285@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 12, 2010 at 03:28:50PM -0500, Mark F. Brown wrote:
> 5V supply for USB ports, LCD connector, and HDMI
> 
> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>

Might make sense to represent this as a fixed voltage regulator (they
can control a GPIO enable line) if it's possible to usefully power this
supply off in low power modes?
