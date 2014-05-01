From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Thu, 01 May 2014 19:36:39 +0200
Subject: [PATCH v3 1/9] mtd: nand: define struct nand_timings
In-Reply-To: <20140430175157.GB2497@norris-Latitude-E6410>
References: <1394647664-8258-1-git-send-email-b.brezillon.dev@gmail.com>
 <1394647664-8258-2-git-send-email-b.brezillon.dev@gmail.com>
 <20140430175157.GB2497@norris-Latitude-E6410>
Message-ID: <53628627.2020401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On 30/04/2014 19:51, Brian Norris wrote:
> Hi Boris,
>
> On Wed, Mar 12, 2014 at 07:07:36PM +0100, Boris BREZILLON wrote:
>> +
>> +/**
>> + * struct nand_sdr_timings - SDR NAND chip timings
>> + *
>> + * This struct defines the timing requirements of a SDR NAND chip.
>> + * These informations can be found in every NAND datasheets and the timings
>> + * meaning are described in the ONFI specifications:
>> + * www.onfi.org/~/media/ONFI/specs/onfi_3_1_spec.pdf? (chapter 4.15 Timing
> Can you remove the unicode U+200E character?

Sure

>
>> + * Parameters)
> Please document the units for these fields here. It looks like you're
> using picoseconds.

I'll add field units (which are indeed picoseconds) to this comment.

Best Regards,

Boris
