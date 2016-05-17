From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 00:43:58 +0200
Subject: [GIT PULL] SoCFPGA DTS updates for v4.7, part3
In-Reply-To: <1462891391-13876-1-git-send-email-dinguyen@kernel.org>
References: <1462891391-13876-1-git-send-email-dinguyen@kernel.org>
Message-ID: <2600031.fLUcj7Vapa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 May 2016 09:43:11 Dinh Nguyen wrote:
> If not too late, please pull in this patch for v4.7.
> 
> Thanks,
> Dinh
> 
> The following changes since commit 02da2d72174c61988eb4456b53f405e3ebdebce4:
> 
>   Linux 4.6-rc5 (2016-04-24 16:17:05 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_for_next_v4.7_dts_part_3
> 
> for you to fetch changes up to fca689561e8170ad954b982b9ce2160a06d9435e:
> 
>   ARM: dts: socfpga: add ethernet alias on Arria10 (2016-05-03 09:25:21 -0500)
> 
> ----------------------------------------------------------------
> SoCFPGA DTS update for v4.7, part 3
> - Add ethernet alias on Arria10
> 

I was going to put this into the next/late branch that already has some other
changes, but in the end I decided to drop it because it is based on
a later -rc release than the other branches, and doesn't seem obvious
or important enough.

Just a clarification about the contents of the patch, you write:

    Without having an ethernet alias, ethernet will have a random MAC address,
    versus take an address that was provided from the bootloader.

Why is the alias needed to get the right MAC address? How does the
bootloader pass it?

	Arnd
