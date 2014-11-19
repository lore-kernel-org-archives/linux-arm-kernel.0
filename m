From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 19 Nov 2014 16:40:57 +0100
Subject: [PATCH] ARM: dts: Specify Odroid X2/U3 audio clock parents and
 rates
In-Reply-To: <007701cfe1d1$3f4c1940$bde44bc0$@kernel.org>
References: <1410360223-18363-1-git-send-email-s.nawrocki@samsung.com>
 <5432C5C5.7020206@samsung.com> <007701cfe1d1$3f4c1940$bde44bc0$@kernel.org>
Message-ID: <546CBA09.8070308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/14 03:51, Kukjin Kim wrote:
>> > On 10/09/14 16:43, Sylwester Nawrocki wrote:
>>> > > This ensures the core and the audio subsystem clocks are configured
>>> > > properly, as expected by the sound machine driver. These bits are
>>> > > missing to obtain proper audio sample rates in kernel v3.17, where
>>> > > audio support for Odroid X2/U3 was first added.
>>> > >
>>> > > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>> > > ---
>>> > > It would be good to have it applied as a fix for v3.17.
>> > 
>> > Anything happened to this patch ? I can't see it neither in Linus' nor
>> > -next tree. And we are already at 3.18 merge window.
>> > 
> Hi Sylwester,
> 
> Sorry about that. I'll queue this one into fixes for -3.18 and stable maybe
> +3.17 only if stable-3.17 is available...

Kukjin,

You didn't forget about this patch, did you ?
It's been over 2 months since I've sent it and sound on Odroid X2/U3
is still broken as it was then. Please send the patch upstream.

--
Thanks,
Sylwester
