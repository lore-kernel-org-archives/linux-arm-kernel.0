From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 16 Jul 2016 18:36:59 +0200
Subject: [PATCH v0 07/10] arm: orion5x: Remove old non-DT-based WNR854T
 support
In-Reply-To: <1468679348-10522-8-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1468679348-10522-8-git-send-email-jm@lentin.co.uk>
Message-ID: <20160716163659.GH1777@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 16, 2016 at 03:29:05PM +0100, Jamie Lentin wrote:

Again, you need a commit log. It could be something like:

The setup file for the wnr854t has bit rotted to such an extent it no
longer works. Replace it with a working device tree description.

       Andrew
