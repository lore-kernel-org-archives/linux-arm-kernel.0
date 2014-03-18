From: fthain@telegraphics.com.au (Finn Thain)
Date: Tue, 18 Mar 2014 23:00:12 +1100 (EST)
Subject: [PATCH 00/12] scsi/NCR5380: fix debugging macros and #include
 structure
In-Reply-To: <1395112756.20860.1.camel@joe-AO722>
References: <20140318002822.372705594@telegraphics.com.au>
 <1395112756.20860.1.camel@joe-AO722>
Message-ID: <alpine.LNX.2.00.1403182208590.2018@nippy.intranet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, 17 Mar 2014, Joe Perches wrote:

> 
> My preference would be to change dprintk to scsi_dbg

Can you be more specific? I gather you're not referring to the debugging 
routines in include/scsi/scsi_dbg.h as they aren't equivalent.

Is it the name "dprintk" you object to?

I went looking in drivers/scsi/ for some kind of naming convention for a 
conditional printk. There are some other variations on the theme (DEBUG, 
PDEBUG, PERROR, etc) but dprintk() seems to be the most popular.

-- 
