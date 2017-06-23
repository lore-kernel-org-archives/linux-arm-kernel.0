From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 Jun 2017 16:14:43 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.13 (#2)
In-Reply-To: <CAK8P3a3UuLFVxZv1o1+gKSafsGgV=vgWRM_yjnT_E4fAUPZx8g@mail.gmail.com>
 (Arnd Bergmann's message of "Fri, 23 Jun 2017 14:32:51 +0200")
References: <877f041a4p.fsf@free-electrons.com>
 <CAK8P3a3UuLFVxZv1o1+gKSafsGgV=vgWRM_yjnT_E4fAUPZx8g@mail.gmail.com>
Message-ID: <87wp82yeng.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On ven., juin 23 2017, Arnd Bergmann <arnd@arndb.de> wrote:


>
>
> Please send a revert for that, and remove the code that tries to
> parse the dma-mask from DT from that driver!

I see on IRC you agree with Antoine about it the driver part. For the DT
part do you want a PR with the revert or just the patch alone?

Thanks,

Gregory

>
>        Arnd

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
