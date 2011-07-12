From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Jul 2011 13:12:45 +0200
Subject: [PATCH 04/17] mach-versatile: retire custom LED code
In-Reply-To: <CAK5ve-KwL4rX65FqyWcZrvAcx0vFcGDpWQXgm67P8n2MDpNHWQ@mail.gmail.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-5-git-send-email-bryan.wu@canonical.com>
	<20110710092836.GT4812@n2100.arm.linux.org.uk>
	<CAK5ve-KwL4rX65FqyWcZrvAcx0vFcGDpWQXgm67P8n2MDpNHWQ@mail.gmail.com>
Message-ID: <CACRpkdZ-PKLW--5KAXM9paWoFpcmWrOfq6ax8pyZWU7QA=z+pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 4:02 PM, Bryan Wu <bryan.wu@canonical.com> wrote:
> On Sun, Jul 10, 2011 at 5:28 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>>
>> Shouldn't this be part of the previous patch? ?The previous patch changes
>> both Realview and Versatile by touching plat-versatile.
>>
>
> I will fold them together, if Linus has no problem about it.

I have no problems with anything, and I'm not one bit picky about
SoB:s and Author: tags, I'm more concerned about the LED code
getting cleaned up. Just do whatever it takes to make good patches
out of this!

Thanks,
Linus Walleij
