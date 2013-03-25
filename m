From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 25 Mar 2013 19:29:35 +0100
Subject: [PATCH] ARM: dove: add more hardware description in the DT
In-Reply-To: <CABJ1b_RrFpKdH3w=v4gvRQ-8UniKOz9o9VVJ8Q=AQz5WaN0NRQ@mail.gmail.com>
References: <20130325103159.0c1b4f17@armhf>
 <CABJ1b_RrFpKdH3w=v4gvRQ-8UniKOz9o9VVJ8Q=AQz5WaN0NRQ@mail.gmail.com>
Message-ID: <20130325192935.1a2bd19c@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Mar 2013 11:21:13 +0100
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> please choose a more informative node names like
> 
> lcd0: lcd-controller at 820000 and

I tried that, but it seems that the name is too long: I cannot get the
external clock from the si5351 clkout0.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
