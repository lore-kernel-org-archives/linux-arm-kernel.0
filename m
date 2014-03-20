From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 20 Mar 2014 09:39:03 -0700
Subject: ARM memset fixes for 3.8.y.x extended
Message-ID: <CAGVrzcbR=o9Maj9YxFs2=-K0E21AWn9dDpSgHMFiGU-GjhLaWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kamal,

Could you schedule the following two patches for the upcoming
3.8.13.20 stable release:

418df63adac5 ARM: 7670/1: fix the memset fix
455bd4c430b0 ARM: 7668/1: fix memset-related crashes caused by recent
GCC (4.7.2) optimizations

These two patches apply cleanly to linux-3.8.y-queue on top of
259e6d8c076a ("ACPI / video: Filter the _BCL table for duplicate
brightness values").

Thanks!
-- 
Florian
