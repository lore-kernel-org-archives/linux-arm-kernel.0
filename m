From: bcousson@baylibre.com (Benoit Cousson)
Date: Wed, 02 Oct 2013 11:25:01 +0200
Subject: [RFC 00/15] Device Tree schemas and validation
In-Reply-To: <E1VR1hx-0000C1-6J@jdl.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
 <524A8289.3050107@baylibre.com> <524ACB76.1010001@gmail.com>
 <524AE4FB.4080906@baylibre.com> <E1VR1hx-0000C1-6J@jdl.com>
Message-ID: <524BE66D.7060308@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On 01/10/2013 17:17, Jon Loeliger wrote:
>> Hi Rob,
>>
>> On 01/10/2013 15:17, Rob Herring wrote:
>>> On 10/01/2013 03:06 AM, Benoit Cousson wrote:
>>>> + more DT maintainers folks
>>>>
>>>> Hi all,
>>>>
>>>> I know this is mostly boring user space code, but I was expecting a
>>>> little bit of comments about at least the bindings syntax:-(
>>>>
>>>> I'd like to know if this is the right direction and if it worth pursuing
>>>> in that direction.
>>>>
>>>> The idea was to have at least some base for further discussion during
>>>> ARM KS 2013.
>>>>
>>>> I feel alone :-(
>>>>
>>>> If you have any comment, go ahead!
>
>
> Benoit,
>
> Sorry, I meant to ask earlier but forgot.
> Shouldn't this development be based on the
> upstream DTC repository and not the in-kernel
> copy of the DTC?

Eventually, yes, but here the main point is to discuss the schema that 
will be used to defined bindings.
In that case, the DTC patches code are mostly a proof of concept using 
the Linux kernel as example.

Regards,
Benoit
