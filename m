From: w@1wt.eu (Willy Tarreau)
Date: Fri, 19 Apr 2013 16:43:24 +0200
Subject: MVEBU and MVNETA driver
In-Reply-To: <517150FF.9010806@itooo.com>
References: <5171419C.2090003@itooo.com> <20130419131237.GC22440@1wt.eu>
 <517150FF.9010806@itooo.com>
Message-ID: <20130419144324.GD22440@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 19, 2013 at 04:13:19PM +0200, Greg wrote:
> Willy, thanks for your fast an accurate answer, this seems to solve the 
> stability issue but not the performance issue.

OK.

> Please look at this strange behavior : 1 iperf will only transmit at 
> ~100Mbps, 100 parallel iperf will transmit at ~950Mb. Reception is not 
> an issue.
> I'm thinking of a socket <-> txQ relationship that would limit 
> transmission rate, but I have no idea on how this is implemented.

Strange, I have not experienced this. Yes a socket size limit could be
the reason. Have you tried with netcat or any simple TCP server instead ?

> >PS: is it indiscrete to ask what board this is ?
> I designed the board myself, if you already heard about it I'd be glad 
> to know you told you about it ;-)

Wow, impressed !

Willy
