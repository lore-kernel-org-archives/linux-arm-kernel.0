From: itaru.kitayama@riken.jp (Itaru Kitayama)
Date: Tue, 7 Jun 2016 17:06:39 +0900
Subject: v4.7-rc2 kernel fails to boot when acpi=force
Message-ID: <125b057c-647b-9db7-11b4-4b7123e4b80a@riken.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Upstream v4.7-rc2 kernel does not boot if parameter acpi is set to force
on Overdrive. (acpi=off gets to the prompt)
When set to force it doesn't get to the Linux boot process and stalls.

Here's the BIOS info:

Version 2.17.1249. Copyright (C) 2015 American Megatrends, Inc.
BIOS Date: 09/03/2015 13:52:32 Ver: ROD0084E00
