From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 08 Oct 2010 10:59:31 +1300
Subject: [PATCH 1/2] ASoC: Add CS4271 codec support
In-Reply-To: <4CAE3FAC.6010508@freescale.com>
References: <4CAD16A5.1090501@bluewatersys.com>
	<4CAE3FAC.6010508@freescale.com>
Message-ID: <4CAE42C3.4070204@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2010 10:46 AM, Timur Tabi wrote:
> Ryan Mallon wrote:
>> + * For setups with variable MCLKs, pass 0 as 'freq' argument. This will cause
>> + * theoretically possible sample rates to be enabled. Call it again with a
>> + * proper value set one the external clock is set (most probably you would do
>> + * that from a machine's driver 'hw_param' hook.
> 
> If you're going to copy/paste parts of my driver verbatim into yours, you should
> put something like this in the comments:
> 
> 	Based on the CS4270 driver by Timur Tabi <timur@freescale.com>
> 

Thanks. CC'ed Alexander, the driver author, who I stupidly left of the
reply list.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
