From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 21 Nov 2012 11:20:37 +0100
Subject: [PATCH 0/4] Dove pinctrl fixes and DT enabling
In-Reply-To: <CACRpkdYAnNCFDCjA67r0h_CSHMifb1Z83YJfYGQV3abPB8uQZg@mail.gmail.com>
References: <1353317996-20841-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkdYAnNCFDCjA67r0h_CSHMifb1Z83YJfYGQV3abPB8uQZg@mail.gmail.com>
Message-ID: <50ACAAF5.2030002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2012 10:59 AM, Linus Walleij wrote:
> On Mon, Nov 19, 2012 at 10:39 AM, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com>  wrote:
>> This patch relies on a patch set for mvebu pinctrl taken through
>> Linus' pinctrl branch. As there is no other platform than Dove
>> involved, I suggest to take it though Jason's tree to avoid any
>> further conflicts.
>
> Sounds like a plan. So you have some commit history pulled
> in from the pinctrl tree in the MVEBU tree?

Linus,

I am referring to patches for a pinctrl/mvebu subfolder. IIRC Thomas
posted that patch a while ago. Jason is currently sorting things out
for mvebu pull requests. I guess both can comment on your question,
as I don't fully understand it.

Sebastian
