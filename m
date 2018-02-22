From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 22 Feb 2018 16:25:46 +0100
Subject: [PATCH Resend 0/5] hwrng: stm32 - Improvement for stm32-rng
In-Reply-To: <20180222140328.GE28447@gondor.apana.org.au>
References: <20180215130312.23612-1-lionel.debieve@st.com>
 <20180222140328.GE28447@gondor.apana.org.au>
Message-ID: <8dcbcea1-78f7-27ff-66a0-a6180d32a05e@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 02/22/2018 03:03 PM, Herbert Xu wrote:
> On Thu, Feb 15, 2018 at 02:03:07PM +0100, Lionel Debieve wrote:
>> This set of patches add extended functionalities for stm32 rng
>> driver.
>> Patch #1 includes a reset during probe to avoid any error status
>> which can occur during bootup process and keep safe rng integrity.
>>
>> Patch #3 adds a new property to manage the clock error detection
>> feature which can be disabled on specific target.
>>
>> Patch #5 rework the timeout calculation for read value that was
>> previously defined based on loop operation and is now based on
>> timer.
> 
> I should take only patches 1/3/5, right?

You could take all (dt-bindings + drivers part).

regards
alex

> 
> Cheers,
> 
