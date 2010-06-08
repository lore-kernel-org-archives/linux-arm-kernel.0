From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 08 Jun 2010 12:38:18 +1200
Subject: [alsa-devel] [RFC PATCH v3 0/3] ep93xx i2s audio
In-Reply-To: <F302D76F-8D7D-4F4B-ACC5-D7F76998AA4A@opensource.wolfsonmicro.com>
References: <1275628285-12642-1-git-send-email-ryan@bluewatersys.com>
	<1275914732.3045.105.camel@odin>
	<4C0D58BB.5030505@bluewatersys.com>
	(sfid-20100607_213827_729716_0AEBDFD1)
	<F302D76F-8D7D-4F4B-ACC5-D7F76998AA4A@opensource.wolfsonmicro.com>
Message-ID: <4C0D90FA.5020400@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> On 7 Jun 2010, at 21:38, Ryan Mallon wrote:
> 
>> Russell, Mark has picked up patch 2/3 via the alsa tree. Should I submit
>> 1/3 and 3/3 via the arm patch system with Liam's ack?
> 
> At least 3/3 needs to go via the ASoC tree since it depends on 2/3. It may make sense for all of them to go that way, or perhaps 1/3 could go separately via the ARM tree (in which case I'd ack it too).

I really don't mind either way, unless Russell has objections to the
core patches going via the alsa tree.

I want to make a couple of changes suggested by Hartley to patches 1/3
and 3/3 which will cleanup the registration interface a little. I will
repost the patches hopefully later today.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
