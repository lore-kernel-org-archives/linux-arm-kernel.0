From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Feb 2014 09:46:56 +0000
Subject: [PATCH RFC 26/46] drivers/base: provide an infrastructure for
 componentised subsystems
In-Reply-To: <CAKMK7uFYhz8Pmv5E7aKY7yzZGDe_m8a0382Njv7tZRoBSfmRpw@mail.gmail.com>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1Vypo6-0007FF-Lb@rmk-PC.arm.linux.org.uk>
 <CAKMK7uFYhz8Pmv5E7aKY7yzZGDe_m8a0382Njv7tZRoBSfmRpw@mail.gmail.com>
Message-ID: <20140207094656.GY26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 10:04:30AM +0100, Daniel Vetter wrote:
> I've chatted a bit with Hans Verkuil about this topic at fosdem and
> apparently both v4l and alsa have something like this already in their
> helper libraries. Adding more people as fyi in case they want to
> switch to the new driver core stuff from Russell.

It's not ALSA, but ASoC which has this.  Mark is already aware of this
and will be looking at it from an ASoC perspective.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
