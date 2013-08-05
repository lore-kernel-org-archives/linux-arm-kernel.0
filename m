From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 05 Aug 2013 15:12:20 +0200
Subject: [PATCH 1/2] ARM: remove dmacap,memset from Device tree binding
In-Reply-To: <20130805122638.GE19280@titan.lakedaemon.net>
References: <1372762453-12018-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1372762453-12018-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130725153104.GH23879@titan.lakedaemon.net>
 <20130804010904.GB19280@titan.lakedaemon.net>
 <20130805095341.GA7594@e106331-lin.cambridge.arm.com>
 <20130805122638.GE19280@titan.lakedaemon.net>
Message-ID: <51FFA4B4.5080807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/13 14:26, Jason Cooper wrote:
> On Mon, Aug 05, 2013 at 10:53:41AM +0100, Mark Rutland wrote:
>> I'm not entirely sure on this. The property described is still true for
>> the device, even if the kernel's not using that information now. My
>> feeling would be to keep them, unless there's a plan to better describe
>> the properties of the XOR channels.
>>
>> It shouldn't harm the kernel to have some properties we don't use at
>> this point in time. If we want to reorganise the binding, the first step
>> would be to make the properties as deprecated, rather than removing them
>> outright.
>
> Ok, that matches what I was originally thinking.  The bindings are
> supposed to be OS-agnostic, so the fact that we no longer use it is
> irrelevant.  The hardware still has the capability.
>
> Sebastian, I'm just going to drop this patch.

Sure, I am fine with dropping it.

Sebastian
