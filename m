From: hotran@apm.com (Hoan Tran)
Date: Sat, 23 Jul 2016 20:00:52 -0700
Subject: hwmon: xgene: Add support for X-Gene hwmon driver
In-Reply-To: <02814a96-c620-c4af-e278-40432f6f701f@riken.jp>
References: <02814a96-c620-c4af-e278-40432f6f701f@riken.jp>
Message-ID: <9D204F6B-7C99-4543-87BF-4D9FC3F6475C@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Itaru,


> On Jul 23, 2016, at 16:51, Itaru Kitayama <itaru.kitayama@riken.jp> wrote:
> 
> Hi Hoan,
> 
> I've been testing your patch set on a Rev B0 system with ACPI, in dmesg
> I see:
> 
> [    1.546444] xgene-slimpro-i2c APMC0D40:00: i2c mailbox channel request failed
> [    1.570062] xgene-slimpro-hwmon APMC0D29:00: no pcc-channel property
> 
> what other packages or subsystems do we need to make this work on ACPI-based systems?

You need the new firmware and BIOS which support ACPI PCC mailbox.

Thanks
Hoan

> 
> Itaru
