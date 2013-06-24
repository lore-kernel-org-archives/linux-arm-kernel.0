From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 24 Jun 2013 16:12:29 +0530
Subject: [GIT PULL] ARM: CPUFreq updates for 3.11
In-Reply-To: <1524748.bV9OZAOR0D@vostro.rjw.lan>
References: <CAKohpo=v4qPDH32Y4ithr_p007nTn5AOUzkUCiHTGgQN6-=BEw@mail.gmail.com>
 <1524748.bV9OZAOR0D@vostro.rjw.lan>
Message-ID: <CAKohpomThmZFKTufBzWpmokqqZJ8C6DtGTKTzBY=OxJPNT-BmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 June 2013 16:19, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, June 24, 2013 11:20:35 AM Viresh Kumar wrote:
>> Hi Rafael,
>>
>> This is part of my patchset "CPUFreq: Fix {PRE|POST}CHANGE notification
>> sequence". It contains changes specific to cpufreq core and ARM drivers.
>>
>> I have left changes to non-ARM cpufreq drivers from this pull request. See if
>> you can take them for 3.11.
>>
>> The following changes since commit 9e895ace5d82df8929b16f58e9f515f6d54ab82d:
>>
>>   Linux 3.10-rc7 (2013-06-22 09:47:31 -1000)
>>
>> are available in the git repository at:
>>
>>   git://git.linaro.org/people/vireshk/linux.git cpufreq-fix-notification-arm
>>
>> for you to fetch changes up to f2d65dd0d573e6961165f0be35bac84997b9e707:
>
> Well, this contains changes that aren't specific to ARM as far as I can say.

Yeah, the first patch touches core. How do you want to proceed with this one
then? You will apply them from mail? Or you will apply first patch (core cpufreq
one) and I should send pull request without it?
