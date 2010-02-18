From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 18 Feb 2010 15:18:14 +1300
Subject: [PATCH] ep93xx: move timer defines into core.c and document
In-Reply-To: <201001121811.28763.hartleys@visionengravers.com>
References: <201001121811.28763.hartleys@visionengravers.com>
Message-ID: <4B7CA366.50801@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> ep93xx: move timer defines into core.c and document
> 
> The timer defines are only used in core.c. Move them so
> they will not be globaly exposed.
> 
> While here, add additional defines to document the magic
> numbers used in the registers. Also, add some comments
> for clarification.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersus.com>

Acked-by: Ryan Mallon <ryan@bluewatersys.com>

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
