From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 27 Nov 2012 17:05:47 +0530
Subject: [PATCH] cpufreq: SPEAr: Add CPUFreq driver
In-Reply-To: <1728458.5AqJNfNVgK@vostro.rjw.lan>
References: <7ec0e3f4b81b70f3def4257e6b9781efd4c7a3d2.1353785862.git.viresh.kumar@linaro.org>
 <20121127040135.GB27305@S2100-06.ap.freescale.net>
 <CAKohpomSAogQVeBQ8HaWwwoTVCsMha5d_1Wid6N3t5SnVZTc=w@mail.gmail.com>
 <1728458.5AqJNfNVgK@vostro.rjw.lan>
Message-ID: <CAKohpo=XirzP5Dj5kZq8Ou7D-W8CjfT8m=_vpjim4oH9jXfdQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 November 2012 17:08, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, November 27, 2012 09:28:01 AM Viresh Kumar wrote:
>> On 27 November 2012 09:31, Shawn Guo <shawn.guo@linaro.org> wrote:
>> > On Sun, Nov 25, 2012 at 01:09:28AM +0530, Viresh Kumar wrote:
>> >> +cpufreq {
>> >> +     compatible = "st,cpufreq-spear";
>> >
>> > I do not think we need a "cpufreq" node, as we already have node for
>> > cpu to contain these.
>>
>> Hmm.. Yes, can be done.
>
> OK, so changes are going to be made to the driver, right?
>
> I'll drop it then and please resubmit when ready (and tested) after the changes.

Yes, for now this would be the only change i have. I can resend it right now,
if you can still pick it for 3.8.

--
viresh
