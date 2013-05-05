From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 5 May 2013 22:22:36 +0200
Subject: Fwd: Tegra 30 System hangs because of commit "pinctrl: move
 subsystem mutex to pinctrl_dev struct"
In-Reply-To: <CACRpkdZdT8==cUtH4=Y3LC-eVu6ntO2ojFC4bSXNuxa4hMJ=ZA@mail.gmail.com>
References: <CAK5ve-KXdS8az=Gtja-mF=Z3_EeZVA7bLYSU0EE2mf5bHmSUKw@mail.gmail.com>
 <CAK5ve-KBDyvjNRVMcXgfnhYcajdcGsuAKaepzCBt+epiXoYvSw@mail.gmail.com>
 <517ED12B.8080502@wwwdotorg.org>
 <20130504133004.GC24282@game.jcrosoft.org>
 <CACRpkdbBVJtWrRO+J=pWjfLXTcVKX++x-eeJQXGeQn_WOURUNQ@mail.gmail.com>
 <20130505112819.GD24282@game.jcrosoft.org>
 <CACRpkdZdT8==cUtH4=Y3LC-eVu6ntO2ojFC4bSXNuxa4hMJ=ZA@mail.gmail.com>
Message-ID: <20130505202236.GF24282@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:57 Sun 05 May     , Linus Walleij wrote:
> On Sun, May 5, 2013 at 1:28 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > On 22:52 Sat 04 May     , Linus Walleij wrote:
> >> On Sat, May 4, 2013 at 3:30 PM, Jean-Christophe PLAGNIOL-VILLARD
> 
> >> > same issue on at91sam9g45ek
> >>
> >> Is it working with mainline (Torvalds) HEAD?
> >
> > now yes
> 
> Thanks! I had some panic there for a while :-)

I was thinking to put a jenkins to test Linus HEAD all the time
And with some automatic test one some hw

to detect it more quick

Best Regards,
J.
