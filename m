From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 21 Jul 2014 09:58:03 +0530
Subject: [PATCH 1/2] PCI: spear: Fix Section mismatch compilation warning
 for probe()
In-Reply-To: <CAL_Jsq+dSoYp83wnXXHnfQ__GkQvoNcijmktvwqvcpazsQGioQ@mail.gmail.com>
References: <76576b662613369d0c71db30ceed4ed5ae1343d2.1405857442.git.viresh.kumar@linaro.org>
 <20140720192649.GA30124@quad.lixom.net>
 <CAKohpokOJLKOwB_rKz0W-1T0nYX7-2_8nm3wQr6khR55x4gqrA@mail.gmail.com>
 <CAL_Jsq+dSoYp83wnXXHnfQ__GkQvoNcijmktvwqvcpazsQGioQ@mail.gmail.com>
Message-ID: <CAKohponUGvs818F-Ch4kFrRPv+vwXkuZotiVjQD9To0LuyNcZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 July 2014 07:45, Rob Herring <robherring2@gmail.com> wrote:
> The Fixes tag is new and the format is documented in SubmittingPatches

Yeah, just saw that for the first time :)

> IIRC. I believe it is also supposed to be quotes rather than
> parentheses around the commit message if we want to be really picky.

Actually both: ("$subject")

I never saw the doc and picked how it was done by Rafael for cpufreq stuff.
Though he was correctly adding 12 digits of the sha key, but the quotes
were missing :)

I will take care of this now.

--
viresh
