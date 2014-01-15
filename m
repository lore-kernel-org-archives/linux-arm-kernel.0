From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 15 Jan 2014 11:02:41 +0100
Subject: [linux-sunxi] [PATCH] pinctrl: sunxi: Honor GPIO output initial
 vaules
In-Reply-To: <CAGb2v64hs1B=5Ss40AD6K=GTOiYqJrG_vCOxrPzWmjjVgFGvXg@mail.gmail.com>
References: <1389711021-16430-1-git-send-email-wens@csie.org>
 <000001cf1189$fc0f8120$f42e8360$@gmail.com>
 <CAGb2v64hs1B=5Ss40AD6K=GTOiYqJrG_vCOxrPzWmjjVgFGvXg@mail.gmail.com>
Message-ID: <20140115100241.GI3377@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

Nice catch :)

On Wed, Jan 15, 2014 at 04:21:12PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Wed, Jan 15, 2014 at 8:37 AM, Ma Haijun <mahaijuns@gmail.com> wrote:
> > Hi,
> >
> > I think it is better to set the output value first to avoid glitch.
> 
> If I understand the user manual correctly, setting the output value
> before changing the pin to output function first will have no effect.

I just tested it on my A31, and it is working as expected (the output
value isn't output until the direction is changed).

It would be great if you could test this as well on your device, and
change it like suggested.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140115/b83fc452/attachment.sig>
