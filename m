From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Mon, 4 Feb 2013 17:01:45 -0300
Subject: [PATCH 0/2] ARM: mvebu: Add support for SPI controller in Armada
 370/XP
In-Reply-To: <20130204194714.GN14746@titan.lakedaemon.net>
References: <1359995888-2385-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130204165119.GA2440@localhost>
 <20130204183733.GM14746@titan.lakedaemon.net>
 <20130204192914.GA2456@localhost>
 <20130204194714.GN14746@titan.lakedaemon.net>
Message-ID: <CALF0-+XPDLeSYBFO6sQ2M24F1f5pgz8tSNMm0VX8BEeda3ym+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Mon, Feb 4, 2013 at 4:47 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> Ezequiel,
>
> On Mon, Feb 04, 2013 at 04:29:15PM -0300, Ezequiel Garcia wrote:
>> On Mon, Feb 04, 2013 at 01:37:33PM -0500, Jason Cooper wrote:
>> > On Mon, Feb 04, 2013 at 01:51:20PM -0300, Ezequiel Garcia wrote:
>> > > The patches are based in Jason Cooper's mvebu/dt branch.
>> >
>> > It probably doesn't matter for this series (I haven't tried to apply it
>> > yet), but please base future work off of a mainline tag (eg v3.8-rc6).
>> > It makes merge conflicts easier to resolve.
>> >
>> > Feel free to test-merge against the mvebu/ branches and let me know of
>> > any conflicts.
>> >
>>
>> Ah, I see.
>>
>> I was mistakenly assuming you wanted against that branch;
>> I'll base the patches on mainline in the future.
>
> Nope, the branches are organized that way to sanely merge in with all
> the other arm-soc code.  While I make every effort to keep them stable
> (ie, not rebased), they may change at anytime if I need to fix things.
>
> tags are stable, and if all patches are based on tags, then merge
> conflicts follow a predictable pattern.  Anything else devolves into
> chaos.
>

Ah?... this explains why I was seeing your branches rebased! ;-)

>> > Also, your patch series appears to be out of order, did you use git
>> > send-email once per file?
>>
>> I always send the cover letter manually. This time I did it after the patches.
>> I'm in the process of automating this in my workflow,
>> but feel free to make a suggestion.
>
> if format-patch is called properly (I know from experience how to call
> it improperly ;-) ), you can just do
>
> $ git send-email ... /path/to/patches/*.patch
>
> and it'll get the order correct.  It will also ask for confirmation
> before sending each email.
>
> Dry-run sending a series just to yourself lets you see how it will
> appear once it goes out to the list.
>

Okey, great. Thanks for the advices!

-- 
    Ezequiel
