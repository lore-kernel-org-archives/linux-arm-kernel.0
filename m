From: josh.coombs@gmail.com (Josh Coombs)
Date: Tue, 3 Jul 2012 10:52:17 -0400
Subject: [PATCH v2 11/12] ARM: Kirkwood: Use DT to configure SATA device.
In-Reply-To: <1341325365-21393-12-git-send-email-andrew@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-12-git-send-email-andrew@lunn.ch>
Message-ID: <CAMW5Ufa2bsYs9VD2g9hJWKpcQNcZt+WXCA1ohYoHeLk9SambSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 3, 2012 at 10:22 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> Convert boards using DT, but the old way of configuring SATA to now
> use properties in there DT file.

Andrew, should I be updating my GoFlex patch set to work with these
new Kirkwood DT abstractions, and if so is there a specific tree you'd
prefer I work against, or should I wait to see if my existing patch
set is approved as is and update with a new patch once these updates
land in an RC?

Josh Coombs
