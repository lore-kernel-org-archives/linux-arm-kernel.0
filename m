From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 13 May 2011 09:29:18 +1200
Subject: [PATCH] [media] at91: add Atmel Image Sensor Interface (ISI)
	support
In-Reply-To: <Pine.LNX.4.64.1105121413220.24486@axis700.grange>
References: <1305186138-5656-1-git-send-email-josh.wu@atmel.com>	<20110512114530.GE18952@game.jcrosoft.org>
	<Pine.LNX.4.64.1105121413220.24486@axis700.grange>
Message-ID: <4DCC512E.1000603@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2011 12:14 AM, Guennadi Liakhovetski wrote:
> On Thu, 12 May 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> [snip]
> 
>>> +	if (0 == *nbuffers)
>> please invert the test
> 
> Don't think this is required by CodingStyle or anything like that. If it 
> were, you'd have to revamp half of the kernel.

It should at least be consistent within a file, which it is not true in
this case. I think the preferred style is to have the variable on the left.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
