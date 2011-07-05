From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 5 Jul 2011 15:26:37 +0800
Subject: [PATCH 4/7] pxa25x: separate lubbock handling to lubbock-usb
	transceiver
In-Reply-To: <4E0DB417.3070401@gmail.com>
References: <1301666188-11822-1-git-send-email-dbaryshkov@gmail.com>
	<1301666188-11822-4-git-send-email-dbaryshkov@gmail.com>
	<BANLkTik42CkEDKLU6BCkcZMVQ3HqQ07aLQ@mail.gmail.com>
	<BANLkTikttxQMk136CoMYsUJFRbicOW+8og@mail.gmail.com>
	<BANLkTi=zo_LrpjhzNANAAqhXUEy_j-jd+w@mail.gmail.com>
	<BANLkTinvjfrEbmeD711YP_ZtQ4UD3BEz0Q@mail.gmail.com>
	<4E0DB417.3070401@gmail.com>
Message-ID: <CAMPhdO-JQuYKVW2ODiwvAZRcJE3TEuBhVZ9VvBXxLJcY_7_P4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe, ping?

Cc'ed Greg KH. Any possibility for this to go quicker, this series has been
delayed for 2 cycles. And the patches look good to me.

Dmitry,

If this is going to be merged through the usb tree, what are the other
patches that have no dependency?

- eric

On Fri, Jul 1, 2011 at 7:48 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Hello,
>
> On 07.04.2011 05:48, Eric Miao wrote:
>>
>> On Thu, Apr 7, 2011 at 5:21 AM, Dmitry Eremin-Solenikov
>> <dbaryshkov@gmail.com> ?wrote:
>>>
>>> On 4/4/11, Eric Miao<eric.y.miao@gmail.com> ?wrote:
>>>>
>>>> David,
>>>>
>>>> Let me know if you're OK I take this patch, as several others following
>>>> have dependency on this one.
>>>
>>> So, what is the current status of this patch?
>>
>> Unfortunately, David passed away as Greg KH announced days ago.
>> I'll take these patches.
>
> I'v seen these patches rest a bit in your tree. It wasn't merged for 3.0.
> Does it stand a chance to be merged into 3.1, or it's better to resubmit
> these patches to usb/gadget subtree to Felipe/Greg?
>
>
> --
> With best wishes
> Dmitry
>
>
