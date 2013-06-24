From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 24 Jun 2013 16:40:27 +0530
Subject: [GIT PULL] ARM: CPUFreq updates for 3.11
In-Reply-To: <7195611.gCcafMWC85@vostro.rjw.lan>
References: <CAKohpo=v4qPDH32Y4ithr_p007nTn5AOUzkUCiHTGgQN6-=BEw@mail.gmail.com>
 <1524748.bV9OZAOR0D@vostro.rjw.lan>
 <CAKohpomThmZFKTufBzWpmokqqZJ8C6DtGTKTzBY=OxJPNT-BmA@mail.gmail.com>
 <7195611.gCcafMWC85@vostro.rjw.lan>
Message-ID: <CAKohpomdnEgDcAExoyN1b4vohHNEg3NDH1mM8NWG8gQoPvff+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 June 2013 16:29, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> In your original series that patch was the last one.  What made you change your
> mind and put it in front?

I initially thought that this one would break git bisect (code would
compile, but would fail) for platforms whose code I have fixed in
this patchset.

But that is true only for failure cases, otherwise code would work as
normal.

And hence kept this at the top this time.
