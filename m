From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Wed, 9 Dec 2015 18:04:21 +0000
Subject: [PATCH] nwflash: use no_seek_end_llseek_size
In-Reply-To: <4235779.ynpqSv1Kc4@wuerfel>
References: <4235779.ynpqSv1Kc4@wuerfel>
Message-ID: <20151209180421.GY20997@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2015 at 05:33:45PM +0100, Arnd Bergmann wrote:
> The recently introduced no_seek_end_llseek was wrong, it should
> be no_seek_end_llseek_size:
> 
> drivers/char/nwflash.c: In function 'flash_llseek':
> drivers/char/nwflash.c:280:8: error: too many arguments to function 'no_seek_end_llseek'

Folded and pushed.
