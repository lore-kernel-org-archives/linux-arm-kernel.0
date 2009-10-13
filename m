From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 14 Oct 2009 09:25:20 +1300
Subject: [PATCH] s3c: Fix adc function exports
In-Reply-To: <20091013201945.GK28849@trinity.fluff.org>
References: <4AD4E096.2060409@bluewatersys.com>
	<20091013201945.GK28849@trinity.fluff.org>
Message-ID: <4AD4E230.7080800@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks wrote:
> On Wed, Oct 14, 2009 at 09:18:30AM +1300, Ryan Mallon wrote:
>> A couple of mistakes were picked up in the s3c adc driver during the
>> review of Christian Gagneraud's ep93xx adc patches.
>  
>> ---
>> Make s3c_adc_start static since it is not used by any other driver, and
>> fix the export of s3c_adc_read.
> 
> s3c_adc_start is used by ts driver which is under review, so please don't
> remove it. The other part is correct, I'll chop and apply.

Okay, thanks. I take it you are applying to your tree, I don't need to
fix and submit to the patch system?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
