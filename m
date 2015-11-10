From: olof@lixom.net (Olof Johansson)
Date: Tue, 10 Nov 2015 15:23:30 -0800
Subject: [GIT PULL 2/6] ARM: SoC cleanups for v4.4
In-Reply-To: <CA+55aFzUHRvx-=ioeqT-QK+Od6yGixL3q5jit6kD6-Yf5WKXJA@mail.gmail.com>
References: <1447126404-10567-1-git-send-email-olof@lixom.net>
 <1447126404-10567-3-git-send-email-olof@lixom.net>
 <CA+55aFzUHRvx-=ioeqT-QK+Od6yGixL3q5jit6kD6-Yf5WKXJA@mail.gmail.com>
Message-ID: <CAOesGMj8T=qJWkR=yF8cVrTZKiRTBhEsqTLO7Rw9kmB-sPUCKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 2:52 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Nov 9, 2015 at 7:33 PM, Olof Johansson <olof@lixom.net> wrote:
>>
>> Conflicts:
>>
>> OMAP timer code has a treewide fix vs code deletion conflict. Delete
>> the code in HEAD, go with contents from branch.
>
> That doesn't look right. It also needs the clocksource_of_init ->
> clocksource_probe changes. The code was moved around rather than
> deleted.

Argh, yes, of course. I usually build a local copy of the merged
contents on top of your latest tree before sending the pull requests,
but didn't this time.

Thanks for catching this.


-Olof
