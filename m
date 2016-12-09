From: gerg@uclinux.org (Greg Ungerer)
Date: Fri, 9 Dec 2016 13:02:45 +1000
Subject: [PATCH 4/4] ARM: versatile: support configuring versatile machine
 for no-MMU
In-Reply-To: <58481DD1.6090606@arm.com>
References: <1481093992-30520-1-git-send-email-gerg@uclinux.org>
 <1481093992-30520-2-git-send-email-gerg@uclinux.org>
 <CACRpkdZywn46QbnvKcN-jkt43Vf+GBSNQkLgnnNg-DC-8aSO5w@mail.gmail.com>
 <58481DD1.6090606@arm.com>
Message-ID: <ed67c89a-3f40-2634-f873-5890ba2c2f90@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On 08/12/16 00:33, Vladimir Murzin wrote:
> Hi Linus,
> 
> On 07/12/16 14:11, Linus Walleij wrote:
>> Another target I had in mind was the Integrator which
>> incidentally supports a bunch of the old noMMU core
>> tiles where we can swap in an ARM946, which I guess
>> could work with this?
> 
> Do you mind trying my "Allow NOMMU for MULTIPLATFORM" series [1]? Greg just
> reported it did a trick for Versatile, there is a good chance it would work
> for Integrator too ;)
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg546823.html

I won't speak for Linus...

But I tried building with your patches for Integrator/CP and
that builds (with an appropriate configuration) with CONFIG_MMU
disabled and runs successfully in qemu (with machine target
"integratorcp"). No other patches required.

Regards
Greg
