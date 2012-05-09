From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 May 2012 14:07:41 +0200
Subject: [RFC 4/5] pinctrl: SPEAr: Add gpio ranges support
In-Reply-To: <CAOh2x=mG8nJ8QLOJYniysBw=vkNSaQ=m0XHAh0foU3A7ozpuqg@mail.gmail.com>
References: <cover.1335526926.git.viresh.kumar@st.com>
 <4f7690c68b1fa5ef14b29b88fed50237e068fe4d.1335526926.git.viresh.kumar@st.com>
 <CACRpkdbhbESbQWX=5RC86X9Z+R767oijDB4myw=bSRay9ud-qQ@mail.gmail.com>
 <201205071528.48460.arnd@arndb.de>
 <CAOh2x=mG8nJ8QLOJYniysBw=vkNSaQ=m0XHAh0foU3A7ozpuqg@mail.gmail.com>
Message-ID: <CACRpkdafExQGNBUq6XKivYYuyTtdcWY=Bt2XetFP=+xx2_T5hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2012 at 5:58 PM, viresh kumar <viresh.linux@gmail.com> wrote:
> On Mon, May 7, 2012 at 8:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:

>> but open-coding is generally ok too. Note that you can sometimes save a lot
>> of lines if you don't first define all those constants as macros but
>> treat a table like this as the place where you put the raw numbers
>> from the data sheet, if that the only code location in which they are
>> used.
>
> Hmm. Will try to do something better.

No big deal, you can keep the table as long as I don't get Torvalds backfire
on me for introducing too many lines of code. I'm a bit sensitive about that
but it's not like it's super-important.

I've come to accept the fact that pin controller have many lines of code,
since they bascially contain the tables that other platforms put in BIOS
firmware, and these systems typically don't have BIOS:es so...

Thanks,
Linus Walleij
