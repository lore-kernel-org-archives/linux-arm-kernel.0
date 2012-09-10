From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 10 Sep 2012 10:40:06 +0200
Subject: [PATCH 1/2] gpio/twl4030: get platform data from device tree
In-Reply-To: <504DA503.5050901@ti.com>
References: <1346831186-29947-1-git-send-email-florian.vaussard@epfl.ch>
 <1346831186-29947-2-git-send-email-florian.vaussard@epfl.ch>
 <504A2FF2.7070607@ti.com> <504DA20D.7020903@epfl.ch>
 <504DA503.5050901@ti.com>
Message-ID: <504DA766.1080304@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Benoit,

>>
>> I fixed them since it was trivial, but next time you should ensure
>> that the patch pass checkpatch before posting.
>> Sorry for these errors. I however checked my patches before submitting,
>> and had no such warnings. I redone, and remarked that these warnings
>> appear only with the "--strict" option, which is not enabled by default.
>> Is this the recommended  guideline? Thus why not enabling it by default?
> That's a pretty good question :-)
>
> Maybe the --strict is more a nice to have than a strong requirement?
> Anyway, we'd better run checkpatch with --strict and thus fix any
> cosmetic details that might be in the patch.

Good to know, I will use --strict for the next submissions.

> Cool, I love chocolate. That being said, I'm not sure how tasteful 
> will be the *virtual* chocolate. Regards, Benoit 

Even *virtual*, Swiss chocolate will be the most tasteful (hope no Belgium
friends will see this thread) :-)

Regards,
Florian
