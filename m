From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Feb 2014 12:28:32 +0000
Subject: [PATCH RFC 26/46] drivers/base: provide an infrastructure for
 componentised subsystems
In-Reply-To: <20140207125721.2d925387@armhf>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1Vypo6-0007FF-Lb@rmk-PC.arm.linux.org.uk>
 <CAKMK7uFYhz8Pmv5E7aKY7yzZGDe_m8a0382Njv7tZRoBSfmRpw@mail.gmail.com>
 <20140207094656.GY26684@n2100.arm.linux.org.uk>
 <20140207125721.2d925387@armhf>
Message-ID: <20140207122832.GA26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 12:57:21PM +0100, Jean-Francois Moine wrote:
> I started to use your code (which works fine, thanks), and it avoids a
> lot of problems, especially, about probe_defer in a DT context.
> 
> I was wondering if your componentised mechanism could be extended to the
> devices defined by DT.

It was developed against imx-drm, which is purely DT based.  I already
have a solution for the cubox armada DRM.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
