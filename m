From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Sep 2012 22:55:47 -0700
Subject: [GIT PULL] Renesas ARM-based SoC: SoC for 3.7
In-Reply-To: <20120911045152.GG23356@verge.net.au>
References: <1346896928-5750-1-git-send-email-horms@verge.net.au>
 <20120907214951.GA2766@quad.lixom.net>
 <20120908001024.GA28510@verge.net.au>
 <20120911045152.GG23356@verge.net.au>
Message-ID: <CAOesGMgCK=1f4NnJab+uDcGtKtbwuESK0SEPeJefHteuprMB-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 10, 2012 at 9:51 PM, Simon Horman <horms@verge.net.au> wrote:
> On Sat, Sep 08, 2012 at 09:10:26AM +0900, Simon Horman wrote:
>> On Fri, Sep 07, 2012 at 02:49:51PM -0700, Olof Johansson wrote:
>> > Hi,
>> >
>> > On Thu, Sep 06, 2012 at 11:02:07AM +0900, Simon Horman wrote:
>> > > Hi Olof, Hi Arnd,
>> > >
>> > > please consider the following SoC enhancement from
>> > > Phil Edworthy for inclusion in 3.7.
>> > >
>> > > ----------------------------------------------------------------
>> > > The following changes since commit 7952717adb69efc1d2443a1858f96d23c2fb93e0:
>> > >
>> > >   ARM: shmobile: kzm9g: enable restarting (2012-08-25 14:39:44 +0900)
>> > >
>> > > are available in the git repository at:
>> > >
>> > >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git soc
>> >
>> > The above is based on the previous branch we pulled from you (kzm9g), and
>> > contains a patch to support rebooting of a board. I would have expected that to
>> > be the base for your board branch but not the SoC branch.
>> >
>> > Did you mean to base them like this for some other reason that I didn't
>> > realize, or would you mind switching the two branches so that the board
>> > one includes the restart change but not the other way around?
>>
>> Sorry about that, I'll switch things around.
>
> Hi Olof,
>
> I was going to switch things around as you suggest, but I noticed
> that the reason that I did things this way is that my kzm9g branch
> was pulled into the next/soc branch of the arm-soc tree (commit
> 301fd5c13257862df66c81c48d963d474e63e0ef).

Ah, gotcha, and also noticing my own slight confusion here.

First, since there's no overlap with the old and the new branch,
there's no need to base them on each other (since they won't cause
merge conflicts, and order of merging them in doesn't have other
dependencies either).

But it also makes sense from your development point of view to stack
them, since that's how you'll end up building up the branches anyway.
So:

> With that in mind, do you want to take this pull-request as is?

Nah, no need, sorry for the confusion. I'll pull it in as it is into next/soc.


-Olof
