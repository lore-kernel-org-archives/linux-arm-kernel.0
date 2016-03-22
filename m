From: inki.dae@samsung.com (Inki Dae)
Date: Wed, 23 Mar 2016 08:54:15 +0900
Subject: Who is going to merge it [Was: Re: [PATCH v14 0/17] Add Analogix
 Core Display Port Driver]
In-Reply-To: <20160322233906.GP19428@n2100.arm.linux.org.uk>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
 <1919945.Y1tg0YzXlm@diego> <56F1CAEB.3080701@samsung.com>
 <8949624.HmxDpZAlt2@diego> <56F1D0AD.8030905@samsung.com>
 <20160322233906.GP19428@n2100.arm.linux.org.uk>
Message-ID: <56F1DB27.4040001@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



2016? 03? 23? 08:39? Russell King - ARM Linux ?(?) ? ?:
> On Wed, Mar 23, 2016 at 08:09:33AM +0900, Inki Dae wrote:
>> In this case, someone else may send an email again like you "who is going to merge?"
>> That would be why we need a maintainer.
>>
>> drm panel is already managed well by Thierry Reding without such confusion. 
> 
> You don't need a maintainer for every subdirectory just because it's
> a subdirectory...
> 
> Sometimes, having too many maintainers adds beaurocracy which becomes

Yes, but... if there is no someone who is responsible for maintainership, then we would receive such emails like Heiko sent "who is going to merge" 
I don't also want adding many maintainers unnecessary but drm bridge - although the framework is a thin and small - is used *over the ARM SoC* so that many confusions may happen for upstream.

So although it's small framework or just subdirectory, we would need someone who can manage the framework to avoid further confusion if necessary.

Thanks,
Inki Dae

> counter-productive.  dw_hdmi seems to be adequately managed so far
> without there needing to be a "DRM bridge maintainer".
> 
