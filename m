From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 9 Mar 2017 14:15:21 -0800
Subject: outreachy
In-Reply-To: <20170309212021.GA24433@kroah.com>
References: <alpine.DEB.2.20.1703092133340.2306@hadrien>
 <443f0143-aec1-2559-a2c2-73b245632948@broadcom.com>
 <2da12619-5fcb-9e0f-b6c1-c83cbf491e8d@wwwdotorg.org>
 <20170309212021.GA24433@kroah.com>
Message-ID: <c165d5f0-e087-9677-70ad-9db602d8c51f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2017 01:20 PM, Greg KH wrote:
> On Thu, Mar 09, 2017 at 01:56:49PM -0700, Stephen Warren wrote:
>> On 03/09/2017 01:51 PM, Scott Branden wrote:
>>> Hi Julia,
>>>
>>> On 17-03-09 12:36 PM, Julia Lawall wrote:
>>>> Hello,
>>>>
>>>> I discussed the issue of outreachy patches for bcm with Greg, and we are
>>>> not convinced that not having the patches CCd to you is such a good idea.
>>>> While we don't want to spam you with noise, some of the applicants are
>>>> starting to make more significant changes that it could be useful for you
>>>> to be aware of.
>>>>
>>>> Could we try a compromise where you are not CCd on whitespace patches,
>>>> but
>>>> you are CCd on patches that actually modify the code?
>>>
>>> All I'm asking is you work through your outreachy patches internal first
>>> to get rid of the most basic mistakes and email traffic it is geerating.
>>>  Once that learning process is through then they can be sent out like
>>> any other patches to the kernel mailing lists and maintainers.
>>
>> +1 from me too; I find these patches rather high volume and had to add a
>> filter to keep them out of my primary inbox.
> 
> Hah!  That's the joy of being a maintainer of a driver in staging.  Even
> if you filter out outreachy, you are going to get a lot of "basic
> mistakes" and other type patches cc:ed to you.
> 
> I strongly suggest, that if you all don't like this type of stuff,
> either:
> 	- work to get the code out of staging as soon as possible (i.e.
> 	  send me coding style fixes for everything right now, and then
> 	  fix up the rest of the stuff.)
> 	- take yourself off the maintainer list for this code.

Keep in mind that most people on this CC list are getting these patches
because of the bcm283* regular expression, and maybe that's what needs
fixing here in the first place.

Incidentally, Stephen did send a patch to get him removed from the
MAINTAINERS entry for Raspberry Pi stuff, so I guess, problem solved for
him. We still have a ton of people from Broadcom who are going to
receive these emails, with mild interest in staging patches.

> 
> It's your choice, outreachy right now is a lot of patches, but again,
> it's not going to keep you from getting the "basic" stuff sent to you
> in ways that is totally wrong.

That is absolutely true, but the thing is that we really got a big spike
of patch submissions lately, and that was totally not accepted. I am not
asking for a "heads-up" email telling people that they are going to
receive more traffic than usual (because that would be too much over
head), but if there was an internal review first on the outreachy
mailing-list and second a proper submission which is going to pass your
acceptance criteria, we would be de facto reducing the amount of emails
that we received.

The outreachy list obviously has people like you and Julia who are
willing to help and provide feedback, so I really don't see what's the
problem in setting up a two tier review here, it does not change
anything for you, but it does change a lot for us.
-- 
Florian
