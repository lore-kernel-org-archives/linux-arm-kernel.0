From: ipaton0@gmail.com (Iain Paton)
Date: Thu, 08 Jan 2015 17:17:06 +0000
Subject: [linux-sunxi] Re: ARM: dts: sunxi: A20-OlinuXino-Lime2 raise
 dcdc2 lower voltage limit
In-Reply-To: <CAGb2v64xsLpQ63GuxDRj+X454f-FaHHqS+2QpEWEnvgVO2NFQA@mail.gmail.com>
References: <54ADB179.9000209@gmail.com>
 <CAGb2v64xsLpQ63GuxDRj+X454f-FaHHqS+2QpEWEnvgVO2NFQA@mail.gmail.com>
Message-ID: <54AEBB92.9050909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/15 03:54, wens Tsai wrote:

> You should lower the maximum voltage as well, either in this patch
> or when you redo all the regulators. AFAIK the SoC certainly cannot
> take up to 2.275V. The regulator nodes are supposed to say what
> the board can handle.

Yes, I suspect several of them are not currently sensible. I just used 
the limits from the pmic datasheet at the time as there were no other 
boards with axp209 regulator defined, no fex file for the lime2 etc.

I likely would have sent a full respin based on your patches, but as 
only bits have been applied it seemed better to do this minimal one 
and fix the rest properly later. 
I can do a couple of the other Olimex boards that I have available 
to test while I'm doing it.

Iain
