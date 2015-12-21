From: eric@anholt.net (Eric Anholt)
Date: Mon, 21 Dec 2015 15:09:39 -0800
Subject: [PATCH v2 4/8] ARM: bcm2835: Split the DT for peripherals from
 the DT for the CPU
In-Reply-To: <20151218100041.GA1145@omega>
References: <1450310115-22163-1-git-send-email-eric@anholt.net>
 <1450310115-22163-5-git-send-email-eric@anholt.net>
 <20151218100041.GA1145@omega>
Message-ID: <871tafflfw.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Aring <alex.aring@gmail.com> writes:

> Hi Eric,
>
> On Wed, Dec 16, 2015 at 03:55:11PM -0800, Eric Anholt wrote:
>> The set of peripherals remained constant across bcm2835 (Raspberry Pi
>> 1) and bcm2836 (Raspberry Pi 2), but the CPU was swapped out.  Split
>> the files so that we can include just peripheral setup in 2836.
>> 
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>> -
>>  		arm-pmu {
>>  			compatible = "arm,arm1176-pmu";
>>  		};
>>  	};
>
> This is bcm2835 related only? It's still inside bcm283x.dtsi, see [0].
> The rename here makes it a little hard to review.

Good catch.  Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151221/dcb8598d/attachment.sig>
