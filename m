From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Oct 2015 09:01:03 -0700
Subject: [PATCH 3/3] ARM: dts: Add basic support for isee igepv5
In-Reply-To: <CAMVEqEmDoQvnVfQXF9QvtyjPe2RRGe1wf=6=VifGPcSOKLcnbg@mail.gmail.com>
References: <1444756728-11185-1-git-send-email-tony@atomide.com>
 <1444756728-11185-3-git-send-email-tony@atomide.com>
 <CAFqH_52T8rPJp-8+Bb7Tjv-kcACU8FJGtqFWOhj02DzQ2yc7nw@mail.gmail.com>
 <20151016145707.GU10113@atomide.com>
 <CAMVEqEkoXoE1wgT8p5BNW7TAjz5Xtcvx7gXvk7rbdQXg8bXpzg@mail.gmail.com>
 <20151019145052.GB21839@atomide.com>
 <CAMVEqEmDoQvnVfQXF9QvtyjPe2RRGe1wf=6=VifGPcSOKLcnbg@mail.gmail.com>
Message-ID: <20151020160103.GC3078@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pau Pajuel <ppajuel@gmail.com> [151020 03:34]:
> 2015-10-19 16:50 GMT+02:00 Tony Lindgren <tony@atomide.com>:
> >
> > My guess is that you need to play with initrd_high etc, try doing something
> > like this in u-boot:
> >
> > setenv fdtaddr 80a00000
> > setenv loadaddr 80c00000
> > setenv rdaddr 81400000
> > setenv fdt_high 8c000000
> > setenv initrd_high ffffffff
>
> Setting the above environment variables works for me

OK good to hear. Applying this series into omap-for-v4.4/dt then.

Thanks,

Tony
