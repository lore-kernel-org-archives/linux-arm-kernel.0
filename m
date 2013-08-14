From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 14 Aug 2013 08:20:17 -0700
Subject: arm-soc: Xilinx Zynq DT changes for v3.12
In-Reply-To: <CAOesGMiT3Vw9_YKu86ve2NH-h_ZD+nrVDe94Rtqh6DcAf9gCUw@mail.gmail.com>
 (Olof Johansson's message of "Tue, 13 Aug 2013 23:17:34 -0700")
References: <520A47C3.5000106@monstr.eu> <87r4dxfbuk.fsf@kernel.org>
 <87ioz9dt1c.fsf@kernel.org> <520B1A89.8080704@monstr.eu>
 <CAOesGMiT3Vw9_YKu86ve2NH-h_ZD+nrVDe94Rtqh6DcAf9gCUw@mail.gmail.com>
Message-ID: <871u5w5mfi.fsf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson <olof@lixom.net> writes:

> On Tue, Aug 13, 2013 at 10:50 PM, Michal Simek <monstr@monstr.eu> wrote:
>
>> I wasn't aware about using earlier -rc. The last information I got
>> is that these trees should be based on Linux -rc (or tagged if you like) version.
>> I will keep this in my mind and will use earlier versions in the next pull requests.
>
> Yes, the request to not always go with the latest -rc is new for this
> release cycle, so we're generally not pushing back and enforcing it,
> just asking nicely :)
>
> However, since Kevin just got up to speed at the same time, he might
> have been of the impression that it's something we've been asking for
> in the past. :)
>
> The reason for asking is that if we keep getting new and different
> -rcs as bases for merge requests, the history starts to look like a
> lot of merge-backs from upstream, when there's rarely a real need for
> being based on such a new -rc.  Still, it's not a big deal, and we've
> been doing it that way now for a couple of years, but I think we could
> avoid some of it without causing anyone more work (once they're used
> to it :).
>
>> It is just one single patch and I believe you have to use rc5
>> and resolve that all conflicts anyway that's why it is just question
>> of time when you have to deal with it.
>
> Ah, I saw that there was a branch included from the zynq tree and
> figured this was in it. I'll let Kevin handle the merge so it's up to
> him if he prefers to rebase back or just merge it in with -rc5.

I'll take care of the merge with -rc5 this time.

Kevin
