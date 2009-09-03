From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Thu, 03 Sep 2009 21:48:15 +0900
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090903110652.GB2954@sirena.org.uk>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902100500.GA4012@sirena.org.uk>
	<20090902121158.GU32606@prithivi.gnumonks.org>
	<1b68c6790909020644k757827f4kf590779f384ceccb@mail.gmail.com>
	<4A9F0BEE.1060904@samsung.com> <20090903110652.GB2954@sirena.org.uk>
Message-ID: <4A9FBB0F.8060006@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/3/2009 8:06 PM, Mark Brown wrote:
> On Thu, Sep 03, 2009 at 09:21:02AM +0900, Joonyoung Shim wrote:
>> On 9/2/2009 10:44 PM, jassi brar wrote:
> 
>>> S3C2410 has I2S-2.0, S3C6410 has I2S-3.2 and I2S-4.0, S5P6440 has
>>> I2S-4.0, S5PC100 has
> 
>> I wonder what mean the numbers(2.0, 3.2, 4.0, 5.1). Does it mean I2S 
>> version simply? If it is version, what is the differences of each I2S
>> version?
> 
> It's just the version numbers for the IP blocks.  The differences tend
> to be in the addition of new features to the blocks, plus occasional
> reorganisations of the register maps.  For example, the v4.0 block added
> two extra data out lines for 5.1 audio support.  Since you work at

I see. if we use the default feature only, i think the codes of mainline
can be reused because all I2S versions have basically the features of
I2S-2.0(S3C2410).

> Samsung I suspect your best bet for documentation on what's going on is
> to find an internal source - sadly the datasheets and other detailed
> collateral are not public but I'd expect that they are available within
> Samsung.
> 

Right. Unfortunately i am not on Samsung LSI linux team, but I do
a related work on other team.
