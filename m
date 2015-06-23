From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 23 Jun 2015 10:52:53 +0200
Subject: [PATCH 8/8] dt: cpufreq: st: Provide bindings for ST's CPUFreq
 implementation
In-Reply-To: <20150623083856.GH3245@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-9-git-send-email-lee.jones@linaro.org>
 <20150623023458.GC16776@linux> <20150623070651.GA3245@x1>
 <20150623075509.GF16776@linux> <20150623083856.GH3245@x1>
Message-ID: <CABxcv=nRiPkC8wXt02LhFF+0CGjAMKusNWGQLbL+RrvsFS1iMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lee and Viresh,

On Tue, Jun 23, 2015 at 10:38 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 23 Jun 2015, Viresh Kumar wrote:
>> On 23-06-15, 08:06, Lee Jones wrote:
>> >
>> > > Over that, this patch should have been present before any other
>> > > patches using these bindings.
>> >
>> > I've never heard that one before, but it's easy to re-order the set.
>>
>> I don't know, but it seems obvious to me: Bindings first and then the
>> code.
>
> Do you always write your documentation before implementing a
> feature?
>
> Surely it goes;
>   Requirements Gathering
>   Plan and Prepare
>   Implement
>   Test
>   Document
>   Deliver
>
> ;)
>
> ... but as I say, I can re-order if required.  It's really not a problem.
>

This is actually documented in
Documentation/devicetree/bindings/submitting-patches.txt:
...

  3) The Documentation/ portion of the patch should come in the series before
     the code implementing the binding.

....

The rationale AFAIU is that it is easier to review the implementation
of a binding after reading the DT binding doc since then you can see
if the code matches what the DT binding describes.

Best regards,
Javier
