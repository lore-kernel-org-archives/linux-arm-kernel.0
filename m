From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 10 Dec 2013 14:31:12 +0100
Subject: [PATCH] arm64: Add hwcaps for crypto and CRC32 extensions.
In-Reply-To: <20131210115837.GA23226@linaro.org>
References: <1383081038-3241-1-git-send-email-steve.capper@linaro.org>
 <20131210115837.GA23226@linaro.org>
Message-ID: <CAKv+Gu8zqLh_xESV5VWMSu7OjAoZUMWhaVHLxdvnZf7ZFrFJaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 December 2013 12:58, Steve Capper <steve.capper@linaro.org> wrote:
> On Tue, Oct 29, 2013 at 09:10:38PM +0000, Steve Capper wrote:
>> Advertise the optional cryptographic and CRC32 instructions to
>> user space where present. Several hwcap bits [2-6] are allocated.
>>
>> Signed-off-by: Steve Capper <steve.capper@linaro.org>
>
> Hi,
> I was wondering if this patch looked ok to people?
>

As discussed at Connect, it would be nice if we could also allocate
the Aarch32 compat bits and set them at the same time.

Regards,
Ard.
