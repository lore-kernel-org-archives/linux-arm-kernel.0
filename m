From: libv@skynet.be (Luc Verhaegen)
Date: Mon, 25 Aug 2014 17:18:22 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140825151255.GA14967@ulmo.nvidia.com>
References: <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com> <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com> <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <CAKON4OyjJ+QcBGOzrUDH9J+DxBEKLmXeOcnUyOHHHV_DtCG0zA@mail.gmail.com>
 <53FB47B8.2090104@redhat.com> <20140825151255.GA14967@ulmo.nvidia.com>
Message-ID: <20140825151822.GC21020@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 05:12:58PM +0200, Thierry Reding wrote:
> 
> Out of curiosity, how does this work in practice? How does the
> bootloader create this entry? Does it scan the DT to see which clocks
> the real hardware device references and then simply copies them to the
> simplefb node?
> 
> Thierry

https://www.mail-archive.com/linux-sunxi at googlegroups.com/msg06619.html

Luc Verhaegen.
