From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 15 May 2015 19:45:25 +0530
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <CAKohpokeKtcJdrBcPZBBPR2zfJgpvuM_=wRaX5q1Uto2qx1oHQ@mail.gmail.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150512214224.16410.15922@quantum> <20150513085528.GA6994@linux>
 <20150513110357.GD3066@sirena.org.uk>
 <20150514003201.20636.83883@quantum>
 <CAKohpokeKtcJdrBcPZBBPR2zfJgpvuM_=wRaX5q1Uto2qx1oHQ@mail.gmail.com>
Message-ID: <20150515141525.GK6348@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-05-15, 03:25, Michael Turquette wrote:
> No, we don't understand the problem space well enough to form an ABI.

And why do you think so? We have been facing many problems since a
long time which we are trying to solve here.

I agree that it might not be right to try too many things which may
not be required later, but most of the things we have now in new
bindings are actually required.

> Putting this stuff in C without any philosophical constraints on whether
> or not we can change it later is the way to go.

I don't agree to that :)

-- 
viresh
