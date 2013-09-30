From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Sep 2013 18:47:09 +0200
Subject: [PATCH V3: Add Smp support for Allwinner A20. 1/3] Add smp
 support for Allwinner A20(sunxi 7i).
In-Reply-To: <CAK3cCBwOpkk5ObeEm+by=RS6jSptPdGZM+fvpgGZpX9TPij5gg@mail.gmail.com>
References: <1379852488-32147-1-git-send-email-cinifr@gmail.com>
 <1379852488-32147-2-git-send-email-cinifr@gmail.com>
 <20130923181707.GR2779@lukather>
 <CAK3cCBwLrnV7L9WzJ+1P_62PEjEEtgzVjFH8m6SZzWG1O+2vEw@mail.gmail.com>
 <20130925184435.GH2954@lukather>
 <CAK3cCBwOpkk5ObeEm+by=RS6jSptPdGZM+fvpgGZpX9TPij5gg@mail.gmail.com>
Message-ID: <20130930164709.GA5287@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fan,

On Sat, Sep 28, 2013 at 09:48:11PM +0800, cinifr wrote:
> Hi  Maxime,
>     I have test it, but I found it does not work. If using
> smp_prepare_cpus, the kernenl cannot find the secondary cpus because
> that smp_prepare_cpus semms not be excuted before kernel is booting
> secondary cpus. So I have to use early_initcall.

At least two other platforms (sti and rockchip) do it like that.

And an early_initcall is not an option.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130930/d7a9e4c7/attachment.sig>
