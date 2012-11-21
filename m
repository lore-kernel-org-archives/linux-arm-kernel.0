From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Nov 2012 15:45:42 +0100
Subject: [PATCH 0/4] Dove pinctrl fixes and DT enabling
In-Reply-To: <50ACAAF5.2030002@gmail.com>
References: <1353317996-20841-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkdYAnNCFDCjA67r0h_CSHMifb1Z83YJfYGQV3abPB8uQZg@mail.gmail.com>
 <50ACAAF5.2030002@gmail.com>
Message-ID: <CACRpkdYzQuv8sPk57CvqiwMmV0z007cGqVkGOENmr_aYAN14=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 11:20 AM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> On 11/21/2012 10:59 AM, Linus Walleij wrote:
>>
>> On Mon, Nov 19, 2012 at 10:39 AM, Sebastian Hesselbarth
>> <sebastian.hesselbarth@gmail.com>  wrote:
>>>
>>> This patch relies on a patch set for mvebu pinctrl taken through
>>> Linus' pinctrl branch. As there is no other platform than Dove
>>> involved, I suggest to take it though Jason's tree to avoid any
>>> further conflicts.
>>
>>
>> Sounds like a plan. So you have some commit history pulled
>> in from the pinctrl tree in the MVEBU tree?
>
>
> Linus,
>
> I am referring to patches for a pinctrl/mvebu subfolder. IIRC Thomas
> posted that patch a while ago. Jason is currently sorting things out
> for mvebu pull requests. I guess both can comment on your question,
> as I don't fully understand it.

So what I mean is that the patches creating pinctrl/mvebu is in the
pinctrl tree, so if patches in the MVEBU tree depend on these,
then it must have pulled in a branch from pinctrl or applied the
same patches in that tree too (which is OK *sometimes*).

Yours,
Linus Walleij
