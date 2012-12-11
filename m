From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Dec 2012 14:42:08 -0800
Subject: [PATCH V3] ARM: bcm281xx: Add timer driver
In-Reply-To: <201212112238.19528.arnd@arndb.de>
References: <1355250387-622-1-git-send-email-csd@broadcom.com>
 <50C785DD.8030407@broadcom.com> <50C7993B.4070201@wwwdotorg.org>
 <201212112238.19528.arnd@arndb.de>
Message-ID: <CAOesGMiCfSk+cSpummtPEG+h058qoW-ob8Ug9JoAkaGMMRmfaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 2:38 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 11 December 2012, Stephen Warren wrote:
>> Olof, Arnd, that brings me to the question of:
>>
>> Should I:
>>
>> a) Add that branch into linux-next (e.g. via the Tegra tree's for-next)
>> right after v3.8-rc1, let is sit there for a week or two (to allow
>> rebasing to squash in any fixes that show up as being needed), and then
>> send a pull request to arm-soc as a stable branch,
>>
>> or:
>>
>> b) Send a pull request to arm-soc right after 3.8-rc1, and let you do
>> any rebasing/squashing needed, before declaring it stable say around
>> 3.8-rc2 or 3.8-rc3?
>
> I think either way works fine. The first one is less work for us though ;-)

Ah, looks like I hit "reply" instead of "reply all" earlier when I said:

We can pull it in as a non-stable branch that we can rebase if you
send us replacement branches, and then move it to a "stable" version
around rc2/3. I think that's probably easier than doing it all the way
"up" through linux-next for other subarch maintainers.

So, yeah, whatever will be easier for everyone.

-Olof
