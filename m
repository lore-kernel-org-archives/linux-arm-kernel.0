From: itaru.kitayama@riken.jp (Itaru Kitayama)
Date: Sun, 24 Jul 2016 08:51:57 +0900
Subject: hwmon: xgene: Add support for X-Gene hwmon driver
Message-ID: <02814a96-c620-c4af-e278-40432f6f701f@riken.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hoan,

I've been testing your patch set on a Rev B0 system with ACPI, in dmesg
I see:

[    1.546444] xgene-slimpro-i2c APMC0D40:00: i2c mailbox channel 
request failed
[    1.570062] xgene-slimpro-hwmon APMC0D29:00: no pcc-channel property

what other packages or subsystems do we need to make this work on 
ACPI-based systems?

Itaru
