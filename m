From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 7 Nov 2011 15:03:55 -0800
Subject: [PATCH v3 0/8] Add support for tegra30 and cardhu
In-Reply-To: <1320675617-20751-1-git-send-email-pdeschrijver@nvidia.com>
References: <1320675617-20751-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173F9A525A@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Monday, November 07, 2011 7:20 AM:
> This patchset adds support for the tegra30 SoC and the cardhu development
> board.
> 
> Pathset is on top of Will Deacon's ARM reset work.

Peter, how did you test this on Tegra30/Cardhu?

I took the branch you send me containing all your patches and built it. I
tried booting this using both our internal Tegra30 U-boot, and using
fastboot from an internal Android Honeycomb image. In both cases, as soon
as the kernel started, it spewed a line or two of binary garbage on the
serial port, then nothing. Can you fill me in on details like:

a) What .config you used
b) What kernel command-line you used
c) Do you have an A01 or A02 CPU on your Cardhu, and how much RAM?
d) What bootloader you used (exact git commit ID of U-Boot, or the 
Android build ID)
e) Do you have any local changes applied that may help boot work but aren't
in your patchset, or the branch you sent me?

Perhaps we should work on this off-list and report back once I've got it
working.

Thanks.

-- 
nvpublic
