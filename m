From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 31 Oct 2017 13:18:41 +0100
Subject: [PATCH] arm64: support __int128 on gcc 5+
In-Reply-To: <20171031121701.GI5584@arm.com>
References: <CAHmME9pE+G0V-nyKchQyG03YXbPjGykL1xX0M8E544Rh7QrgOQ@mail.gmail.com>
 <20171031114319.24436-1-Jason@zx2c4.com> <20171031115156.GF5584@arm.com>
 <CAHmME9qZq4rsspQ2BFWMXp1boj8YRuvbyfqKWtdPs=6BO9Bm0g@mail.gmail.com>
 <20171031121701.GI5584@arm.com>
Message-ID: <CAHmME9pey+8YcDg9+vkoVGU0qBkc6dqY7RXFYFr=RzcTb7qb+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 1:17 PM, Will Deacon <will.deacon@arm.com> wrote:
>
> Sure, I'll wait for your patch that matches the relevant compiler versions.

That's the patch in this thread:
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/539943.html

As mentioned in there, gcc does the right thing for 5 and up:
https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=d1ae7bb994f49316f6f63e6173f2931e837a351d
