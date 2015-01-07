From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 7 Jan 2015 15:31:49 +0530
Subject: [PATCH 01/17] ARM: sunxi: Register cpufreq-dt for sun[45678]i
In-Reply-To: <CAGb2v64Qv1Nhy2w--4T7ujw9NC17QhJdmrn0VyDtTajv+tu+NQ@mail.gmail.com>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-2-git-send-email-wens@csie.org>
 <20150106155532.GR7853@lukather>
 <CAGb2v64Qv1Nhy2w--4T7ujw9NC17QhJdmrn0VyDtTajv+tu+NQ@mail.gmail.com>
Message-ID: <CAKohpon33KzojZL+u8hjAJdhXzY-c_V96xCgd+Pa7+cP=p6Tbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 January 2015 at 14:37, Chen-Yu Tsai <wens@csie.org> wrote:
> I believe you are referring to the work done by Viresh Kumar (CCed),
> specifically the 2 series "[RFC V1 0/8] CPUFreq: create platform-dev
> for DT based cpufreq drivers" and "[RFC] OPP: Redefine bindings to
> overcome shortcomings". So far the new code has not appeared in
> linux-next. If it does, I will happily use it.

Yes. You still have to create these platform devices for cpufreq-dt.
