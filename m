From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Fri, 22 Jun 2018 05:55:18 -0700
Subject: Crash in netlink/sk_filter_trim_cap on ARMv7 on 4.18rc1
In-Reply-To: <CALeDE9PP__kPHX_aW24kwzGf9BgA0gQOQJSY+Qw0yFMOLn4Pcw@mail.gmail.com>
References: <CALeDE9PP__kPHX_aW24kwzGf9BgA0gQOQJSY+Qw0yFMOLn4Pcw@mail.gmail.com>
Message-ID: <7ff516fd-1d01-4d7a-1d5d-b58932c0c69d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/22/2018 04:19 AM, Peter Robinson wrote:
> Hi All,
> 
> I'm seeing this netlink/sk_filter_trim_cap crash on ARMv7 across quite
> a few ARMv7 platforms on Fedora with 4.18rc1. I've tested RPi2/RPi3
> (doesn't happen on aarch64), AllWinner H3, BeagleBone and a few
> others, both LPAE/normal kernels.
> 
> I'm a bit out of my depth in this part of the kernel but I'm wondering
> if it's known, I couldn't find anything that looked obvious on a few
> mailing lists.
> 
> Peter

Hi Peter

Could you provide symbolic information ?

Thanks !
