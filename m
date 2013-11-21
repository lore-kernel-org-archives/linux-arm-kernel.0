From: olof@lixom.net (Olof Johansson)
Date: Thu, 21 Nov 2013 10:52:31 -0800
Subject: Patches from ARM folks solicited for the -stable tree
In-Reply-To: <20131121185021.GA15057@kroah.com>
References: <alpine.DEB.2.02.1311210442560.30143@utopia.booyaka.com>
 <20131121153254.GA3422@kroah.com>
 <alpine.DEB.2.02.1311211818000.30143@utopia.booyaka.com>
 <20131121185021.GA15057@kroah.com>
Message-ID: <CAOesGMh=55jMdPE-wNha-A4hvRBNhAwWqZzWVSDxtcAApe4jAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 10:50 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Nov 21, 2013 at 06:20:29PM +0000, Paul Walmsley wrote:
>> On Thu, 21 Nov 2013, Greg Kroah-Hartman wrote:
>>
>> > On Thu, Nov 21, 2013 at 04:43:37AM +0000, Paul Walmsley wrote:
>> >
>> > > These days it seems like I have about one patch per merge window that
>> > > could be a stable candidate.
>> >
>> > That's all?
>>
>> The better we are at writing and testing our patches, the fewer -stable
>> candidates we'll have :-)
>
> No new device ids?  quirks?  And if you aren't finding bugs in your
> code, then no one's using it :)

It's been common that we need driver changes _and_ DTS updates, so
things have fallen off the list because of that.

I do have a couple of DTS changes I've been meaning to submit but
never got around to. Any week now...


-Olof
