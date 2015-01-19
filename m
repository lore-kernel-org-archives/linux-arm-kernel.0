From: mpeg.blue@free.fr (Mason)
Date: Mon, 19 Jan 2015 23:03:54 +0100
Subject: RFC on cpufreq implementation
In-Reply-To: <CAKohponGjLkniP2=Aj-Jsg7hfAEnW3p0+EwtrobdCymgT-yqgg@mail.gmail.com>
References: <54B7F7CD.7030903@free.fr>
 <CAKohponGjLkniP2=Aj-Jsg7hfAEnW3p0+EwtrobdCymgT-yqgg@mail.gmail.com>
Message-ID: <54BD7F4A.6020605@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/2015 08:52, Viresh Kumar wrote:
> On 15 January 2015 at 22:54, Mason wrote:
>> I decided to expose only a small subset of frequencies (namely
>> {999,500,333,111} MHz) because, in my tests, the ondemand gov
>> chose mostly min and max, and the intermediate frequencies not
>> so much; so I figured "2 intermediate freqs" is good enough.
>> (I'm ready to hear otherwise.)
> 
> Following patch solved this issue in 3.17..
> 
> 6393d6a1027e cpufreq: ondemand: Eliminate the deadband effect

Good to know, thanks! (I'm on 3.14)

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=6393d6a1027ec1d69ec6246f6c7c2186f76c2abb

Do you have other comments/suggestions regarding my code?

Regards.
