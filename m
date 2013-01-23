From: davem@davemloft.net (David Miller)
Date: Wed, 23 Jan 2013 02:52:40 -0500 (EST)
Subject: [PATCH 1/2 net-next] net: fec: add napi support to improve
 proformance
In-Reply-To: <CAHrpEqQ3-prqJaCmt1hfOr4GzDVyuRNvko1SCyQZHdALhHkhkw@mail.gmail.com>
References: <1358914330-3768-1-git-send-email-Frank.Li@freescale.com>
 <20130123072635.GO1906@pengutronix.de>
 <CAHrpEqQ3-prqJaCmt1hfOr4GzDVyuRNvko1SCyQZHdALhHkhkw@mail.gmail.com>
Message-ID: <20130123.025240.1835436694088754169.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


NAPI should not be configurable, all device drivers should be NAPI
only.
