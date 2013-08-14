From: olof@lixom.net (Olof Johansson)
Date: Wed, 14 Aug 2013 14:41:00 -0700
Subject: [Git pull request] fix to the vexpress/mcpm branch
In-Reply-To: <alpine.LFD.2.03.1308141621430.14472@syhkavp.arg>
References: <alpine.LFD.2.03.1308121428080.14472@syhkavp.arg>
 <20130814055800.GG16635@quad.lixom.net>
 <alpine.LFD.2.03.1308141018140.14472@syhkavp.arg>
 <20130814200834.GA24544@quad.lixom.net>
 <alpine.LFD.2.03.1308141621430.14472@syhkavp.arg>
Message-ID: <CAOesGMgiO+yY9rvADMizsBMKEsUo8+i=BsG_Z5-h02Gi+7Mriw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 1:40 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

>> > Here's the patch nevertheless.  Please apply ASAP as Lorenzo wishes to
>> > base his next pull request on top of this.
>>
>> There's always something more, it seems. What's left?
>
> See below.
>
>> And will it really conflict with the bugfix here or is it just to have
>> it all in the same series?
>
> According to Lorenzo's subsequent reply
>
>   http://article.gmane.org/gmane.linux.ports.arm.kernel/260544
>
> there is no conflict to worry about.

Excellent.

>> The reason I'm asking is that I applied this on next/soc instead of
>> vexpress/mcpm, and we're asking downstream maintainers to not base anthing on
>> next/* branches because it _might_ happen that we rebuild them.
>
> Looking into my inbox, I have the following emails from Lorenzo:
>
>   http://article.gmane.org/gmane.linux.power-management.general/36794
>
>   http://article.gmane.org/gmane.linux.power-management.general/37006
>
>   http://article.gmane.org/gmane.linux.power-management.general/37007
>
>   http://article.gmane.org/gmane.linux.ports.arm.kernel/260441
>
> You apparently were CC'd on all of them, and Lorenzo asked you on two
> occasions how you wanted to handle this, and one of them is an explicit
> pull request addressed to you.

Ok. I was well aware of the cpuidle series, the reason for why I was
asking was that it was unclear if you were referring to that or
something else beyond that.


-Olof
