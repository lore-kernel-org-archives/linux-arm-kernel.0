From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 6 May 2015 10:47:59 -0300
Subject: [PATCH] ARM: dts: imx6qdl-hummingboard: Add PCIe support
In-Reply-To: <CALHpu36GENbeCHf-8HDGwX=weCpb5kCzD_02ZAeXOs3NcW-nzA@mail.gmail.com>
References: <1428540113-24616-1-git-send-email-festevam@gmail.com>
 <20150427085156.GG9231@dragon>
 <20150506103541.GI2067@n2100.arm.linux.org.uk>
 <CALHpu36GENbeCHf-8HDGwX=weCpb5kCzD_02ZAeXOs3NcW-nzA@mail.gmail.com>
Message-ID: <CAOMZO5AEUwvkw85gK1AG+WfczvGHSPWO9aSQ9DKOSyLyOohuDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Wed, May 6, 2015 at 8:04 AM, Jon Nettleton <jon.nettleton@gmail.com> wrote:

> That patch is fine.  In the SolidRun kernel we are actually using
> 0x80000000 as our pin strength to accept the default value, but I have
> previously tested with 0x1b0b1 and it works as expected.

Yes, putting 0x80000000 or 0x1b0b1 has the same effect as 0x1b0b1 is
the default PAD configuration that comes out of reset. I prefer to
pass the value explicitly though.

I tested it with an Intel 7260HMW Wifi card and it worked well.

Regards,

Fabio Estevam
