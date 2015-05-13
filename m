From: nm@ti.com (Nishanth Menon)
Date: Wed, 13 May 2015 10:43:40 -0500
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150513150739.GW2761@sirena.org.uk>
References: <20150507221842.GW22845@sirena.org.uk>
 <CAKohpomU8wm0T=A7EkosdOjXbP8q2Cb726Hsjh08KTKYjoz3-A@mail.gmail.com>
 <555000B6.2010107@ti.com> <20150512052033.GC32300@linux>
 <20150512190134.16410.89041@quantum> <5552510B.9010306@ti.com>
 <20150512194134.GC3066@sirena.org.uk> <55525B29.2080307@ti.com>
 <20150513115422.GQ3066@sirena.org.uk>
 <CAGo_u6o5nw8C3uwLGmP+kbCOG5twmXgC2ATb5Gv-dL3G-grDSg@mail.gmail.com>
 <20150513150739.GW2761@sirena.org.uk>
Message-ID: <5553712C.9090603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2015 10:07 AM, Mark Brown wrote:
> On Wed, May 13, 2015 at 09:24:57AM -0500, Nishanth Menon wrote:
> 
>> - opp-microamp: The maximum current drawn by the device in microamperes
>>   considering system specific parameters (such as transients, process,
>> aging, etc.)
>>   as necessary,  at an  ambient temperature of 25C. This may be used to set
>>   the most efficient regulator operating mode.
> 
> Why specify the temperature?  That 25C is going to be terribly
> inefficient for my snowplow engine control system (or whatever).
> 
:) was trying to put a constraint since we do know that leakage
changes over temperature profile and the fact that operating
temperature ranges vary depending on device and market. rephrased
again below:

- opp-microamp: The maximum current drawn by the device in
  microamperes considering system specific parameters (such as
  transients, process, aging, maximum operating temperature range
  etc.) as necessary. This may be used to set the most efficient
  regulator operating mode.

-- 
Regards,
Nishanth Menon
