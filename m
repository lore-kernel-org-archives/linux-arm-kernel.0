From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Tue, 6 Nov 2012 19:10:35 -0600
Subject: [PATCH v2 1/2] mailbox: OMAP: introduce mailbox framework
In-Reply-To: <20121106085931.GA26335@kroah.com>
References: <1352170552-29564-1-git-send-email-omar.luna@linaro.org>
 <1352170552-29564-2-git-send-email-omar.luna@linaro.org>
 <509886A2.5060509@wwwdotorg.org>
 <CACRpkdb0nCaV5L5xCnzje3w=t7+TZpcvCCUDRPi-10t+oF8UGg@mail.gmail.com>
 <20121106085931.GA26335@kroah.com>
Message-ID: <CALLhW=6V=7Maq4FLpjrMJ015nYKBSnpagb25ZtQ4AVNLfmwsdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 6 November 2012 02:59, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Tue, Nov 06, 2012 at 09:55:52AM +0100, Linus Walleij wrote:
>> On Tue, Nov 6, 2012 at 4:40 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>
>> > Is this a public interface to the driver? If so, shouldn't the header be
>> > in include/linux somewhere?
>>
>> I think the split out of the public header is done in patch 2/2.
>
> Yes, but the names are still omap_*, which doesn't make much sense here.

Ok, I have no problem with this...

I was under the impression that moving this code out of plat-omap was
blocking single zImage support hence the minimal changes to move it to
drivers/.

I will strip the generic portions from omap_ prefixes and resend.

Cheers,

Omar
