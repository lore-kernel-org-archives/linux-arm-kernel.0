From: kamal.dasu@broadcom.com (Kamal Dasu)
Date: Thu, 25 Feb 2016 15:08:03 -0500
Subject: [PATCH] i2c: brcmstb: allocate correct amount of memory for regmap
In-Reply-To: <56CB3A8A.9040401@gmail.com>
References: <1456064238-6294-1-git-send-email-wsa@the-dreams.de>
 <56CB3A8A.9040401@gmail.com>
Message-ID: <270d201d17008$3cae24f0$b60a6ed0$@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> We want the size of the struct, not of a pointer to it. To be future 
> proof, just dereference the pointer to get the desired type.

Thanks for catching and fixing this.

>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>

Kamal
