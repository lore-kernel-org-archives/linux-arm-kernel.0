From: agnel.joel@gmail.com (Joel Fernandes)
Date: Wed, 2 Apr 2014 11:06:33 -0500
Subject: [Qemu-devel] [PATCH] QEMU: ARM: boot: Load kernel at an Image
 friendly address
In-Reply-To: <CAFEAcA-1hWT69JzSv2zJta_PCCuJ-9fH7muBGPD=u+WOLHmvXQ@mail.gmail.com>
References: <1395718484-20424-1-git-send-email-joelf@ti.com>
 <CAFEAcA9Dc5bN_JdMNWODB9Puj9HLoEBm4mDo7ZcaJj97qBbAdw@mail.gmail.com>
 <CAEgOgz6Tou7aOOKsWO2cOaPjWJrkWBFyU-_bApf+ks=qzSKDdA@mail.gmail.com>
 <CAFEAcA-1hWT69JzSv2zJta_PCCuJ-9fH7muBGPD=u+WOLHmvXQ@mail.gmail.com>
Message-ID: <CAD=GYpa8hMuawtGjWMXDfJyCcSpL+n8qwOiMLaXmhJvFvpD=oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 2, 2014 at 7:47 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 2 April 2014 13:11, Peter Crosthwaite <peter.crosthwaite@xilinx.com> wrote:
>> Like others, I have been carrying this change locally. Good to see it up!
>
> Why are you all booting raw Images anyway (just out of curiosity)? All my
> test cases boot either a zImage or a uImage, or occasionally a full SD card
> image, or I'd have noticed this earlier...

zImage fails for me on OMAP1, which I'm debugging, the errors have
more to do with writing out of memory limits. But I was not sure if
the problem was with decompression or something else, so I wanted to
boot the basic case (Image) first.

Thanks,
-Joel
