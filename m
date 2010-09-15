From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 15 Sep 2010 18:46:22 +0200
Subject: [PATCH v5 0/7] native wl1271 support on ZOOM
In-Reply-To: <20100915163403.GT8647@atomide.com>
References: <1283376410-9999-1-git-send-email-ohad@wizery.com>
	<AANLkTikedoL3HjohQfq2qa0TU5yMJR5p1GqyQJtQGrdb@mail.gmail.com>
	<AANLkTingdk=9Fbp9uKf6rGyAtR+b8KV4vFmYRfakkwBs@mail.gmail.com>
	<20100915132149.GA6997@tuxdriver.com>
	<20100915163403.GT8647@atomide.com>
Message-ID: <AANLkTikJMLF7nB-cTgbxWiTOoTU=Onm4CAoetc=htu7e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 15, 2010 at 6:34 PM, Tony Lindgren <tony@atomide.com> wrote:
> * John W. Linville <linville@tuxdriver.com> [100915 06:21]:
>> On Wed, Sep 15, 2010 at 01:08:18PM +0200, Vitaly Wool wrote:
>> > On Wed, Sep 15, 2010 at 11:21 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> > > On Wed, Sep 1, 2010 at 11:26 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> > >> This patchset adds wl1271 support on ZOOM2/3 boards.
>> > >
>> > > Tony, John, let me please suggest merging this through the wireless tree.
>> > >
>> > > wl1271 is a moving target - it keeps changing in the wireless tree and
>> > > merging this patchset there will allow wl1271 developers to have
>> > > everything in a single tree (and prevent merge conflicts in
>> > > linux-next).
>> >
>> > Thanks Ohad, that's what I was about to suggest as well. :)
>>
>> OK, that is fine with me if the omap folks agree?
>
> Yes sounds good to me

Great, I will rebase to wireless-testing an resubmit.

> I think there's still at least some platform_data
> conversation going on though.

Last issue was resolved today with Russell's (and yours) latest answer.

Thanks,
Ohad.

>
> Tony
>
