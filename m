From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 16 Jul 2016 18:15:28 +0200
Subject: [PATCH v0 04/10] arm: orion5x: Generalise mv88f5181l pinctrl
 support for 88f5181
In-Reply-To: <1468679348-10522-5-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1468679348-10522-5-git-send-email-jm@lentin.co.uk>
Message-ID: <20160716161528.GE1777@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 16, 2016 at 03:29:02PM +0100, Jamie Lentin wrote:
> As far as I'm aware the mv88f5181-b1 and mv88f5181l are the same at the
> pinctrl level, so re-use the definitions for both.

Good, you add a new compatibile string. So it if turns out they are
not identical, we can fix it later without causing problems.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
