From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 7 Jan 2015 17:07:10 +0800
Subject: [PATCH 01/17] ARM: sunxi: Register cpufreq-dt for sun[45678]i
In-Reply-To: <20150106155532.GR7853@lukather>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-2-git-send-email-wens@csie.org>
 <20150106155532.GR7853@lukather>
Message-ID: <CAGb2v64Qv1Nhy2w--4T7ujw9NC17QhJdmrn0VyDtTajv+tu+NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 6, 2015 at 11:55 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Tue, Jan 06, 2015 at 10:35:11AM +0800, Chen-Yu Tsai wrote:
>> On sun[45678]i, we have one cluster of identical cores sharing a
>> clock, which is ideal for using cpufreq-dt. Register a platform
>> device for cpufreq-dt.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> While I don't have anything against this patch, I seem to recall that
> it was not necessary anymore, or that there was some work in the
> direction of removing that kind of code, have you looked into that?

I believe you are referring to the work done by Viresh Kumar (CCed),
specifically the 2 series "[RFC V1 0/8] CPUFreq: create platform-dev
for DT based cpufreq drivers" and "[RFC] OPP: Redefine bindings to
overcome shortcomings". So far the new code has not appeared in
linux-next. If it does, I will happily use it.

ChenYu
