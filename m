From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 3 Nov 2015 14:30:20 +0000
Subject: [PATCH DRAFT 2/2] drivers: serial: PL011: [DRAFT] implement
 register diverson for ZTE UART
In-Reply-To: <20151103142343.GX8644@n2100.arm.linux.org.uk>
References: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
 <1446467042-24494-3-git-send-email-andre.przywara@arm.com>
 <20151103142343.GX8644@n2100.arm.linux.org.uk>
Message-ID: <5638C4FC.5080407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/11/15 14:23, Russell King - ARM Linux wrote:
> On Mon, Nov 02, 2015 at 12:24:02PM +0000, Andre Przywara wrote:
>> +static struct vendor_data vendor_zte = {
> 
> This is unreferenced.  What's the detection mechanism for the ZTE UART?

Guess why I didn't include this ;-)

If I get [1] correctly, then it's a "zte,zx296702-uart" compatible
string for a starter (but no AMBA IDs, if I am not mistaken). I'd let
them fill in other ways of detection like ACPI.

Cheers,
Andre.

[1] http://marc.info/?l=linux-serial&m=143832902328904&w=2
