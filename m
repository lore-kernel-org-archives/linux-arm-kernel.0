From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 21 Dec 2012 11:43:31 +0100
Subject: [PATCH] mmc: mmci: Support non-power-of-two block sizes for
 ux500v2 variant
In-Reply-To: <20121221103955.GH14363@n2100.arm.linux.org.uk>
References: <20121121165048.GO3290@n2100.arm.linux.org.uk>
 <CAFEEs1nb+UD+8_jsKvGKhyFqGDogN5wsmV30PnELqahTMDyRVA@mail.gmail.com>
 <20121122173708.GJ5764@n2100.arm.linux.org.uk>
 <50B34270.7070403@stericsson.com>
 <20121126102712.GC19440@n2100.arm.linux.org.uk>
 <50B349D3.2050806@stericsson.com>
 <CAFEEs1nZboGyAfpYQ2hUvp366FiS0=8u5zL6Vr1RfXac_Ls_dw@mail.gmail.com>
 <20121128171221.GF19440@n2100.arm.linux.org.uk>
 <CAPDyKFoq2f2tZqoKAjMjhA3yJFinXM25rJPCyiGaqHw=fEUoMg@mail.gmail.com>
 <CAPDyKFqg0Jb0mNW4riUa7XADKZpQSO0UAjSFKM_tnEOOG3LVxg@mail.gmail.com>
 <20121221103955.GH14363@n2100.arm.linux.org.uk>
Message-ID: <CAPDyKFrQ32ANCwUo39rFNqbHwsKFyDVamMaeNTVC9j4tBjRmkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 December 2012 11:39, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Dec 21, 2012 at 11:36:32AM +0100, Ulf Hansson wrote:
>> Just wanted to conclude on the way forward. Should we fixup pio_write
>> according to how pio_read has been fixed, or should we adapt the check
>> for misaligned buffers to what Per proposed?
>> What do you prefer Russell?
>
> It's really silly to have pio_read doing something that pio_write doesn't
> do - they should have the same behaviour except for the differing data
> flow direction.

I agree. Thanks for your input.

Kind regards
Ulf Hansson
