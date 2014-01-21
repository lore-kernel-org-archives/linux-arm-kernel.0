From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 21 Jan 2014 11:43:17 +0300
Subject: [patch] ARM: mvebu: checking for IS_ERR() instead of NULL
In-Reply-To: <52DE2EB0.9010206@free-electrons.com>
References: <20140121065216.GA31535@elgon.mountain>
 <52DE2EB0.9010206@free-electrons.com>
Message-ID: <20140121084317.GI4815@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 09:24:16AM +0100, Gregory CLEMENT wrote:
> On 21/01/2014 07:52, Dan Carpenter wrote:
> > of_iomap() returns NULL on error, it doesn't return error pointers.
> >
> 
> Hi Dan,
> 
> Thanks for your patch but I already sent this fix yesterday and Jason have
> applied. See: http://thread.gmane.org/gmane.linux.ports.arm.kernel/295642
> 

Cool.  Congrats to Ezequiel on his new corporate email address.  :)

regards,
dan carpenter
