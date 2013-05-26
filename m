From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 26 May 2013 10:36:14 +0200
Subject: Kirkwood CPU Freq driver
In-Reply-To: <51A12DD4.9010907@baker-net.org.uk>
References: <51A12DD4.9010907@baker-net.org.uk>
Message-ID: <20130526083614.GB26249@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 25, 2013 at 10:32:04PM +0100, Adam Baker wrote:
> Hi,
> 
> I've been trying to test Andrew Lunn's work creating a CPU Idle
> driver for Kirkwood.

Hi Adam

Thanks for testing this. I must admit, i never tested it once the
first rc came out. I clearly should of, because its broken. It was a
three part patch series, and only part 1/3 made it in. Hence the
issues you are seeing.

Jason, please can you pick up:

https://patchwork.kernel.org/patch/2051401/
https://patchwork.kernel.org/patch/2080931/

	Andrew
