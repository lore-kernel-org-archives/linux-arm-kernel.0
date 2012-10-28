From: gmbnomis@gmail.com (Simon Baatz)
Date: Sun, 28 Oct 2012 20:50:18 +0100
Subject: [PATCH 0/9] ARM: Kirkwood: Convert to pinctrl
In-Reply-To: <20121028165711.GG15824@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <20121028165711.GG15824@lunn.ch>
Message-ID: <20121028195018.GA16191@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Sun, Oct 28, 2012 at 05:57:11PM +0100, Andrew Lunn wrote:
> On Wed, Oct 24, 2012 at 04:53:45PM +0200, Andrew Lunn wrote:
> > This patchset converts all DT kirkwood boards to using pinctrl.
> 
> I still expect problems with GPIOs used for power off. I've not yet
> touched them. Again, a regulator makes sense, but there is no 'out of
> the box' regulator type or property which adds itself to pm_power_off.

the IB-NAS 62x0 works with the exception of the power off via GPIO. 
Additionally, the original U-Boot enables hardware blinking for the
power led and Jamie's patch might be needed here as well.  However, I
don't use this U-Boot anymore and can't test this.

- Simon
