From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 19 Oct 2010 08:36:22 +1300
Subject: [PATCH] EP93xx: Document DMA M2P API
In-Reply-To: <20101018074335.GD4772@gw.healthdatacare.com>
References: <4CBB99D5.6070009@bluewatersys.com>
	<20101018074335.GD4772@gw.healthdatacare.com>
Message-ID: <4CBCA1B6.1040303@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2010 08:43 PM, Mika Westerberg wrote:
> On Mon, Oct 18, 2010 at 01:50:29PM +1300, Ryan Mallon wrote:
>> Add documentation for the EP93xx DMA memory to peripheral/peripheral to
>> memory API.
> 
> This is a good thing but I think that you might want to use standard
> kernel-doc style comments (see Documentation/kernel-doc-nano-HOWTO.txt)
> so that we can get nicely formatted document of the DMA API when
> 'make *docs' is run.

Ah, thanks. I didn't know there was documentation for kernel-doc :-). I
had just been copying the way other subsystems were done. Will fix up
and repost.

> 
> /**
>  * ep93xx_dma_m2p_client_register - register a client ..
> 
> 
> Also you might want to put these function comments in the .c file (so they
> are as close the actual code as possible).

I prefer the comments in the header, since if the API documentation is
good the user will never have to look at the C code.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
