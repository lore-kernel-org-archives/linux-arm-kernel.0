From: thavatchai.makpahibulchoke@hp.com (Thavatchai Makphaibulcboke)
Date: Fri, 01 Jun 2012 12:58:03 -0600
Subject: [PATCH] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <4FC90E00.7010100@zytor.com>
References: <1337875436-27640-1-git-send-email-tmac@hp.com>
 <20120528070336.GM3377@game.jcrosoft.org> <4FC82D89.1040108@hp.com>
 <4FC83940.9010708@zytor.com> <4FC90C01.2060005@hp.com>
 <4FC90E00.7010100@zytor.com>
Message-ID: <4FC910BB.7030908@hp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2012 12:46 PM, H. Peter Anvin wrote:
> 
> Well, the decompression stuff is under lib/ ... maybe lib/boot/ or
> something like that...
> 
> 	-hpa
> 
> 

Thanks again for the comment.  I thought of putting it under arch to
separate it from the main line kernel to avoid any confusion.  But if
you think it is OK to put under lib/boot, that sounds good to me.

Thanks,
Mak.
