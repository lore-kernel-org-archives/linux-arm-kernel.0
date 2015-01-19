From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 19 Jan 2015 13:22:52 +0530
Subject: RFC on cpufreq implementation
In-Reply-To: <54B7F7CD.7030903@free.fr>
References: <54B7F7CD.7030903@free.fr>
Message-ID: <CAKohponGjLkniP2=Aj-Jsg7hfAEnW3p0+EwtrobdCymgT-yqgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 January 2015 at 22:54, Mason <mpeg.blue@free.fr> wrote:
> I decided to expose only a small subset of frequencies (namely
> {999,500,333,111} MHz) because, in my tests, the ondemand gov
> chose mostly min and max, and the intermediate frequencies not
> so much; so I figured "2 intermediate freqs" is good enough.
> (I'm ready to hear otherwise.)

Following patch solved this issue in 3.17..

6393d6a1027e cpufreq: ondemand: Eliminate the deadband effect
