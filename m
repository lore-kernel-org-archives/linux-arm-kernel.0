From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Sat, 22 Nov 2014 20:45:48 +0200
Subject: [RFC] adp1653: Add device tree bindings for LED controller
In-Reply-To: <201411171615.34822@pali>
References: <20141116075928.GA9763@amd> <201411171601.32311@pali>
 <20141117150407.GP8907@valkosipuli.retiisi.org.uk> <201411171615.34822@pali>
Message-ID: <5470D9DC.70807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

>> Can you capture raw bayer images correctly? I assume green
>> means YUV buffers that are all zero.
>>
>> Do you know more specifically which patch breaks it?
>
> CCing freemangordon (Ivaylo Dimitrov). He tried to debug it
> months ago but without success. Should know more info about this
> problem.
>
> I think that commit which broke it was not bisected...
>

According to my vague memories, the green captured image was a result 
from the ISP IRQ never got triggered. I tried to find why, but never 
succeeded.

Sakari, we discussed that on #maemo-ssu when I was playing with cameras, 
and there is nothing new in that regard:
http://mg.pov.lt/maemo-ssu-irclog/%23maemo-ssu.2013-09-18.log.html#t2013-09-18T18:46:38 
