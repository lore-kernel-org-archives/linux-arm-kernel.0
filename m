From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 9 Sep 2012 15:12:31 -0400
Subject: [PATCH 2/2] ARM: Kirkwood: Convert all DT boards to EHCI via DT.
In-Reply-To: <1346491586-23480-2-git-send-email-andrew@lunn.ch>
References: <1346491586-23480-1-git-send-email-andrew@lunn.ch>
 <1346491586-23480-2-git-send-email-andrew@lunn.ch>
Message-ID: <20120909191231.GC4575@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 01, 2012 at 11:26:26AM +0200, Andrew Lunn wrote:
> Now that the EHCI driver has DT support, drop old style configuration
> of it and add DT in its place. Since all the boards enable the EHCI,
> enable it by default in kirkwood.dtsi. Any new boards which don't have
> USB can specifically disable it.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Applied to:

git://git.infradead.org/users/jcooper/linux.git kirkwood/dt

thx,

Jason.
