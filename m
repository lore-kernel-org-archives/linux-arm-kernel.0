From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 21 Feb 2017 12:27:20 +0100
Subject: [PATCH v2 1/3] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <CAHp75Vcb9gtzF7LvH74JwL4dTUyQvKmg=dnTXKfjhVHuyK3WXg@mail.gmail.com>
References: <1487593718-20752-2-git-send-email-boris.brezillon@free-electrons.com>
 <CAHp75VdwQGP-qa0c0KQwrdpZmCGc3RuEsJ-E-XLbBzQSn4Yxcg@mail.gmail.com>
 <20170220213803.7ba5591e@bbrezillon>
 <20170220215009.0ecbf5a1@bbrezillon>
 <CAHp75VczsC9WdZWR9iCRh2JoNLFZyOtodrsDRYQoyaN7nkyf=A@mail.gmail.com>
 <CAHp75Vc_q-bEzA2-hVpHyR0GZ8mXxwJ8-UjECe31T04mb67q4w@mail.gmail.com>
 <20170221090610.6d531b94@bbrezillon>
 <CAHp75VfZfj-8ih3vg63w_dAq8xXE2Whu1bANXRcXS1_EGNq43A@mail.gmail.com>
 <20170221112641.6276c001@bbrezillon>
 <CAHp75Vcb9gtzF7LvH74JwL4dTUyQvKmg=dnTXKfjhVHuyK3WXg@mail.gmail.com>
Message-ID: <20170221112720.ynehsryprhrhzjla@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(adding Hans-Christian)

On 21/02/2017 at 13:02:21 +0200, Andy Shevchenko wrote:
> Abusing platform data with pointers is also not welcome.
> 
> > (in this case, avr32).
> 
> It's dead de facto.
> 
> When last time did you compile kernel for it? What was the version of kernel?
> Did it get successfully?
> 

v4.10-rc3 was building successfully but had some issues in the network
code.

> When are we going to remove avr32 support from kernel completely?
> 

Ask that to the avr32 maintainers. It still builds and is still booted
by some people. And that actually seems to be you as you reported a bug
we introduced in 4.3. I don't think we had any other report after that.

It can be frustrating at times to handle that platform but if it is
working for someone, I don't see why we would remove it.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
