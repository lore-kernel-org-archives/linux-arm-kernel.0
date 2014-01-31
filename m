From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 31 Jan 2014 11:22:39 +0100
Subject: [PATCH v2 00/21] pinctrl: mvebu: restructure and remove hardcoded
 addresses from Dove pinctrl
In-Reply-To: <CACRpkda5HRxpLWWizT_58SJ6Fb=TQpO=Y5yFThpZkUbUYmU8fg@mail.gmail.com>
References: <1390674856-4993-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkda5HRxpLWWizT_58SJ6Fb=TQpO=Y5yFThpZkUbUYmU8fg@mail.gmail.com>
Message-ID: <52EB796F.9000109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/14 11:17, Linus Walleij wrote:
> On Tue, Jan 28, 2014 at 1:39 AM, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com> wrote:
>
>> This patch set is one required step for Dove to hop into mach-mvebu.
>> Until now, pinctrl-dove was hardcoding some registers that do not
>> directly belong to MPP core registers. This is not compatible with
>> what we want for mach-mvebu.
>
> All this stuff is really nice, so if you can get Thomas to add his
> review-tag on this stuff and maybe have some Tested-by:s
> from other parties, I'd be happy to pull the end result to the
> pinctrl tree, or alternatively provide my ACK for you to take this
> through ARM SoC.

Luckily, we have a "pinctrl/mvebu" subfolder these patches will mess
with. I think it will be better to keep then all together and take
them through the MVEBU branch. This way we can have an eye on it and 
base off subsequent patches without bothering you.

I'll come back to request your ACK as soon as we have sorted it out.

Sebastian
