From: john.stultz@linaro.org (John Stultz)
Date: Mon, 17 Jun 2013 11:14:06 -0700
Subject: [PATCHv2 0/6] Make ARM's sched_clock generic + 64 bit friendly
In-Reply-To: <20130617180211.GJ10269@tarshish>
References: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
 <51AD32A4.5070609@linaro.org>
 <20130604160907.GW27516@mudshark.cambridge.arm.com>
 <51AE2980.6010005@linaro.org> <20130616094501.GG10269@tarshish>
 <51BF37E4.8020006@linaro.org> <20130617180211.GJ10269@tarshish>
Message-ID: <51BF51EE.9020305@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2013 11:02 AM, Baruch Siach wrote:
>> to send
>> >it by Thomas for 3.11 this week.
> Good, thanks. This means that the xtensa ccount sched_clock patch
> (http://lists.linux-xtensa.org/pipermail/linux-xtensa/Week-of-Mon-20130617/001077.html)
> that depends on the third patch in this series, can go in for 3.11, if the
> xtensa maintainer acks it (added to Cc). How should we handle the dependency
> then?
Well, Thomas hasn't picked them up yet, so he could still object, so no 
promises yet :)

As for the dependency, either you can base your patches off of 
tip/timers/core (once the patches land there) and send a pull request to 
the maintainer (so he gets the dependencies in -tip), or we can see 
about queuing your changes via tip/timers/core (assuming you get 
maintainer acks).

thanks
-john
