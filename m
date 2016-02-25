From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Feb 2016 15:16:46 +0100
Subject: [PATCH v6] Fix sun7i pin assignment for IRQ's
In-Reply-To: <20160225005412.GB4736@lukather>
References: <1456161251-2303-1-git-send-email-henry@nitronetworks.nl>
 <20160225005412.GB4736@lukather>
Message-ID: <CACRpkdYmf8-ZPV5q9H3cdZtQDUkbx=bcrVg9a8M3zEAifXxF9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 1:54 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
>
> Usually, the patch title should be prefixed by the subsystem it
> applies to so that maintainer and reviewers can spot it more
> easily. In this case, it would be something like
>
> pinctrl: sunxi: Fix sun7i pin assignment for IRQ's
>
> On Mon, Feb 22, 2016 at 06:14:07PM +0100, Henry Paulissen wrote:
>> After testing IRQ pins we found some bugs in the pinctrl declaration.
>> Both PI* and PC* pins didn't work. PI* pins seemed to be connected
>> to the wrong mux and PC* pins waren't working at all.
>>
>> Please note that the A20 soc manual is contradicting between version
>> and even within the same document for both the PI and PC pins.
>
> Which sections are in contradiction?
>
>> Patch is based on testing with the hardware itself.
>
> How did you test it? Using the sysfs API, or did you have any hardware
> connected to it?

I'm taking this patch out of my tree now following Maxime's comments.

I'm a bit annoyed that it is iterating too quickly as well, I will
wait and see for a while.

Yours,
Linus Walleij
