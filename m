From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 09 Sep 2014 08:05:12 -0700
Subject: [PATCH 00/15] PM / Domains: Cleanups and remove superfluous APIs
In-Reply-To: <2208348.uMLR68bVng@vostro.rjw.lan> (Rafael J. Wysocki's message
 of "Tue, 09 Sep 2014 01:07:14 +0200")
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
 <7ha96eyt9f.fsf@paris.lan> <2208348.uMLR68bVng@vostro.rjw.lan>
Message-ID: <7hr3zkkf6f.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> On Friday, September 05, 2014 08:35:56 AM Kevin Hilman wrote:
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>> 
>> > This patchset has a bit of a history and some parts of it has been posted
>> > earlier.
>> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/262725.html
>> >
>> > The intent is to simplify code for the generic power domain and also some of
>> > the machine specific code that uses the generic power domain.
>> >
>> > Do note, there are dependencies through this patchset, especially related to
>> > the ARM SoC changes, thus they all need to be kept together.
>> 
>> Reviewed-by: Kevin Hilman <khilman@linaro.org>
>
> My understanding is that this is for the whole series.

Correct.

Kevin
