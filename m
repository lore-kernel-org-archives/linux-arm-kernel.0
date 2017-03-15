From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 15 Mar 2017 18:20:33 +0000
Subject: [PATCH v3 1/2] Documentation: bindings: Introduce
 scpi,sensors-scale
In-Reply-To: <20170309101759.18081-2-carlo@caione.org>
References: <20170309101759.18081-1-carlo@caione.org>
 <20170309101759.18081-2-carlo@caione.org>
Message-ID: <57ff035a-b462-6f5d-0100-051e99e9a2b6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/03/17 10:17, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> Document the new property `scpi,sensors-scale` used by the hwmon-scpi
> driver to convert the sensor readings to the correct / expected scale.
> 

I am fine with DT bindings if DT maintainers agree with having one but I
would like to add couple of points to get their feedback:

1. ARM recognized the drawbacks of SCPI which started informally with
   ARM Ltd platforms and got adopted by few vendors. It's now being
   worked on and a much better and scalable replacement protocol is
   being discussed with vendors now. So future enhancement to this SCPI
   protocol is unlikely.

2. AmLogic has diverted from base protocol in many ways and most of them
   are handled with just compatible so far without any need for
   additional bindings. Can we avoid it ?

So based on these, I prefer not to add more bindings to handle such
deviations but make it just AmLogic specific.

-- 
Regards,
Sudeep
