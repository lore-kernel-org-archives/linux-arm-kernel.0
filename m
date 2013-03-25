From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 25 Mar 2013 14:58:17 +0100
Subject: [PATCH v2 00/14] Marvell EBU thermal sensor consolidation
In-Reply-To: <20130325123928.GD2502@localhost>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130325093001.GH5627@lunn.ch> <20130325104513.GC2502@localhost>
 <CABJ1b_S9c=tFT17=HycmuRbW1g4y8AvWJpmwMRJwvQ214Yb3fw@mail.gmail.com>
 <20130325123928.GD2502@localhost>
Message-ID: <CABJ1b_TEvnx7V84PLmHWGGS26xLBDawKtoKjJ=mervo3AJisEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 1:39 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> On Mon, Mar 25, 2013 at 01:23:32PM +0100, Sebastian Hesselbarth wrote:
>> On Mon, Mar 25, 2013 at 11:45 AM, Ezequiel Garcia
>> <ezequiel.garcia@free-electrons.com> wrote:
>> > On Mon, Mar 25, 2013 at 10:30:01AM +0100, Andrew Lunn wrote:
>> >> I've not a strong opinion, but i think separate drivers are better.
>> >
>> > Don't you think a single driver could make maintenance cheaper?
>>
>> Ezequiel, Andrew,
>>
>> just to sum up my opinion on the whole discussion
>>
>
> Thanks for jumping in.
>
>> +1 for formula fixes for kirkwood and dove
>
> Could you test the Dove formula fixes and provide a Tested-by?
> However little the patches maybe, it still makes me nervous
> to send untested patches.

Well, I cannot "test" if temperature values are correct but at least
returned values look reasonable. I suggest to trust Marvell engineers here.

Sebastian
