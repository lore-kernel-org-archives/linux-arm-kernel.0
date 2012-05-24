From: hpa@zytor.com (H. Peter Anvin)
Date: Thu, 24 May 2012 10:41:24 -0700
Subject: [PATCH] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <1337881229.5070.29.camel@joe2Laptop>
References: <1337875436-27640-1-git-send-email-tmac@hp.com>
 <1337880371.5070.24.camel@joe2Laptop> <4FBE6FF6.5090904@zytor.com>
 <1337881229.5070.29.camel@joe2Laptop>
Message-ID: <4FBE72C4.3040204@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2012 10:40 AM, Joe Perches wrote:
> 
> Many of these functions are only optimized in certain cases; if not
> optimized in a particular case, a call to the library function will be
> emitted.
> 

Right, what part of that don't you understand?

	-hpa
