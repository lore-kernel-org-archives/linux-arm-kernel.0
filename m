From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 15 Jan 2015 09:02:23 +0100
Subject: [PATCHv0 2/3] rtc: Add support for Abracon
 AB-RTCMC-32.768kHz-B5ZE-S3 I2C RTC chip
In-Reply-To: <20150114170343.6f8d807a.akpm@linux-foundation.org> (Andrew
 Morton's message of "Wed, 14 Jan 2015 17:03:43 -0800")
References: <cover.1421045942.git.arno@natisbad.org>
 <1ae63ab80cfb39305884bd0c2648a420ba3bc0a5.1421045942.git.arno@natisbad.org>
 <20150114165557.d44c5752.akpm@linux-foundation.org>
 <20150114170343.6f8d807a.akpm@linux-foundation.org>
Message-ID: <87h9vsqxo0.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed, 14 Jan 2015 16:55:57 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
>
>> Something like this?
>
> Leading to changes in [3/3].  Please have a think about where we should
> be calling device_init_wakeup(dev, false) on the error recovery path.
>
> Let me know if I should just drop it all and await a v2...

I'll work on a v2 to handle your comments and suggestions. I will also
take into account the other comment I got regarding the use of "abracon"
instead of "abcn" as vendor prefix for Abracon Corporation.

Thanks for the review.

a+
