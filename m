From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 6 Feb 2013 18:03:05 +0100
Subject: kernel 3.8 make problem
In-Reply-To: <51093541.3020309@openwrt.org>
References: <ttxj4oytvg02pxivwnruketi.1359554350723@email.android.com>
 <20130130150729.4aae5409@armhf> <51093541.3020309@openwrt.org>
Message-ID: <20130206180305.3bbc2d4d@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Jan 2013 15:59:13 +0100
Florian Fainelli <florian@openwrt.org> wrote:

> Are you using make 3.82 by chance?

I moved to make 3.82 and also libc6 2.17 (my Cubox runs Debian armhf
with kernel 3.8-rc6), and I can now make some programs (with make 2.81,
I was getting a seg fault of the child after the first vfork), but I
get the same errors when building a kernel. Does anybody have such a
problem?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
