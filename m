From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 19 May 2010 09:04:59 +1200
Subject: [RFC PATCH 0/3] ep93xx i2s audio
In-Reply-To: <20100518184627.GF22554@sirena.org.uk>
References: <4BF21B67.8090404@bluewatersys.com>
	<20100518184627.GF22554@sirena.org.uk>
Message-ID: <4BF300FB.4020509@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> On Tue, May 18, 2010 at 04:45:27PM +1200, Ryan Mallon wrote:
> 
>>  - Sometimes playback (ie aplay) results in noise. Killing the process
>> and trying again will result in correct playback.
> 
> What does the output data look like in a scope, is it bit shifted
> relative to the clocks for example?

I haven't looked into this too closely yet, but on a scope it is just
complete noise. It doesn't appear to be shifted or anything like that.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
