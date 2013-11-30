From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 30 Nov 2013 12:31:33 -0200
Subject: [RFC] ARM: lib: delay-loop: Add align directive to fix BogoMIPS
 calculation
In-Reply-To: <20131130114937.GY16735@n2100.arm.linux.org.uk>
References: <1385121212-30182-1-git-send-email-festevam@gmail.com>
 <CAOMZO5AyjD4f2o2c-QbK13Pb5cZCWEV4f5dc38MspDBY6_OjDg@mail.gmail.com>
 <20131130114937.GY16735@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5AetDM0N5uLRHBy7UdHcXeA_4U-m4aDOEuOM6hv+cw5Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 30, 2013 at 9:49 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Any chance that you could run hackbench, and build the kernel with
> -falign-functions=32, comparing the kernel without and with this
> option ?
>
> If alignment has as much effect as the above suggests, the results
> may be interesting.

Yes, that would be interesting to know.

I will try to run this test next week, or maybe Tom Evans could try it
sooner if he has a chance.

>
> As far as this patch is concerned, I'm happy with it, please put it in
> the patch system, thanks.

Sent it as 7907/1.

Regards,

Fabio Estevam
