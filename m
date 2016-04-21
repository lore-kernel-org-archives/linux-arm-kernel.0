From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 21 Apr 2016 05:19:49 +0300
Subject: [PATCH 0/3] arm: dts: lpc32xx: update ssp / spi nodes
In-Reply-To: <1461158925.3004.3.camel@localhost>
References: <1460636437-21764-1-git-send-email-slemieux.tyco@gmail.com>
 <5714664C.7080201@mleia.com> <1461014548.27294.10.camel@localhost>
 <489344042.f8O28rOoB7@wuerfel> <1461158925.3004.3.camel@localhost>
Message-ID: <571838C5.4050102@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On 20.04.2016 16:28, Sylvain Lemieux wrote:
> Hi Vladimir,
> 
> On Mon, 2016-04-18 at 23:52 +0200, Arnd Bergmann wrote:
>> On Monday 18 April 2016 17:22:28 Sylvain Lemieux wrote:
>>> On Mon, 2016-04-18 at 07:45 +0300, Vladimir Zapolskiy wrote:
>>>>> Once we have an agreement on who does this, please send a patch to
>>>>> update the MAINTAINERS file.
>>>>
> Will you send a patch to update the MAINTAINERS file or do you want
> me to send it?

I'll send to change, you'll be included as a maintainer, the record
also needs some other updates, e.g. it is not about machine support
but about SoC support etc.

Arnd, I'm not sure if MAINTAINERS update should go though a pull
request (= no explicit SoB from an ARM maintainer) or if you expect
to get a patch and apply it yourself, please advise.

> Should we add the lpc32xx dts to the list of supported file?
> 

There is a possibility to add files by regex, which makes sense
to do after renaming dts files - this is in my first priority todo list.

>>>> I'll send a change on behalf of myself, at this point I don't think that
>>>> pure lpc32xx maintenance (deliberately here I exclude development!) task
>>>> takes more than 20 hours per month, which is affordable for me,
>>>> Sylvain please express your view.
>>>>
>>> I can provide support for pure lpc32xx maintenance task 
>>> (I also exclude development); I can free up to 10-15 hours a
>>> month for doing testing and patch review.
>>
>> Thanks both of you!
>>
>>> Is there any documentation available on the process 
>>> to submit a merge request to the mailing list?
>>
>> We usually teach people on the fly, but you can watch my ELC
>> presentation from last year at https://www.youtube.com/watch?v=msT1O8P6KXQ
>>
>> 	Arnd
> 
> Sylvain

--
With best wishes,
Vladimir
