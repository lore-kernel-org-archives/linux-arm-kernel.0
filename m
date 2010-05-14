From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 May 2010 10:11:16 +0100
Subject: PIPT cache handling on s5pv210 chip
In-Reply-To: <AANLkTilN-B_hvIPWFC8Q02wIcO7nJLmodSj0RyBYZKuk@mail.gmail.com>
References: <AANLkTilN-B_hvIPWFC8Q02wIcO7nJLmodSj0RyBYZKuk@mail.gmail.com>
Message-ID: <20100514091116.GB10339@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 12:49:22PM +0900, Kyungmin Park wrote:
> In s5pv210 code, there's some strange comments. Does anyone who know
> why does it required or more fancy way?

The comments look wrong and don't particularly match the code.  I'd
suggest ignoring this patch until someone reports a problem, and
please ensure that such a report is to LAKML.
