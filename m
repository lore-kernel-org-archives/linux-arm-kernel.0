From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Jan 2014 19:58:20 +0000
Subject: How to support SDIO wifi/bt in DT
In-Reply-To: <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
Message-ID: <20140116195819.GY15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 09:15:17AM -0800, Olof Johansson wrote:
> We've dealt with it with local code in our tree for Chrome OS, and I
> suspect everyone else has too. It's definitely time to solve
> generically.

As there's no code for any Cubox-i or Hummingboard (they're both purely
DT), what this means is that the answer to Wifi/BT support in mainline is
that this is "impossible at the moment"...

I guess this is becoming a higher priority issue which really needs to be
solved somehow. :)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
