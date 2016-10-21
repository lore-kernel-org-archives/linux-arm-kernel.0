From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Fri, 21 Oct 2016 10:57:45 -0700
Subject: [PATCH v5 11/23] usb: chipidea: Emulate OTGSC interrupt enable
 path
In-Reply-To: <20161021021450.GA16461@b29397-desktop>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
 <20161018015636.11701-12-stephen.boyd@linaro.org>
 <20161019011535.GC6294@b29397-desktop>
 <147684198705.24897.12451889548508263144@sboyd-linaro>
 <20161019080211.GA1968@b29397-desktop>
 <147694652997.28344.1048935134595924905@sboyd-linaro>
 <20161020101017.GA32001@b29397-desktop>
 <147699579088.21058.4379586947317571921@sboyd-linaro>
 <20161021021450.GA16461@b29397-desktop>
Message-ID: <147707266552.25233.4203897094706565540@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-10-20 19:14:50)
> 
> I tested my patch, it works well at my side, if it is ok for you, please
> ack it, I will apply it as well as your chipidea series after your
> gpu fix patch at greg's usb-next tree.

Feel free to add my:

Tested-by: Stephen Boyd <stephen.boyd@linaro.org>
Reported-by: Stephen Boyd <stephen.boyd@linaro.org>

tags to the patch.

> 
> Is it ok for you?
> 

Ok sounds good. The GPU patch has been picked up into drm-misc now, but
I'm not sure if it's going to be merged into -rc2 or not but it sounds
like you'll figure that part out.

I'll resend the phy drivers to Kishon now. Thanks.
