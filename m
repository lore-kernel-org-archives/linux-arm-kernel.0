From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 04 Nov 2014 18:06:37 +0100
Subject: [PATCH 11/13] arm: dts: dra7: add DMA properties for UART
In-Reply-To: <20141104170233.GB24112@csclub.uwaterloo.ca>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
 <1412014009-13315-12-git-send-email-bigeasy@linutronix.de>
 <20141104170233.GB24112@csclub.uwaterloo.ca>
Message-ID: <5459079D.7080703@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2014 06:02 PM, Lennart Sorensen wrote:
> 
> According to the manual the DMA channels for UART7 to 10 are:
> 
> uart7:  144 145
> uart8:  146 147
> uart9:  148 149
> uart10: 150 151
> 
> Might as well add those too.  We have uart 7 and 8 in use on our board
> so I am about to go test it.

Mind sharing the manual with me? Mine does not mention DMA channels for
UART7-10. If you are able to test 7+8 (and it works) could you please
make patch which with for the remaining four devices?

Sebastian
