From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 12:18:55 -0800
Subject: [GIT PULL v2] ARM: mvebu: dt for v4.6 (#1)
In-Reply-To: <87twliyzb2.fsf@free-electrons.com>
References: <87twliyzb2.fsf@free-electrons.com>
Message-ID: <20160224201855.GC10126@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 11:04:49AM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the second version of the first pull request for dt for mvebu
> for v4.6.  This one is based on v4.5-rc3 because it depends on fixes
> merged previously.
> 
> As requested by Olof, I aligned the commit title.
> 
> Gregory
> 
> The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:
> 
>   Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.6-1
> 
> for you to fetch changes up to 5dda254d0cc5cbdcc81dbce0985c35b68dd5e3b1:
> 
>   ARM: dts: kirkwood: add device tree for buffalo linkstation ls-qvl (2016-02-09 11:00:26 +0100)
> 
> ----------------------------------------------------------------
> mvebu dt for 4.6 (part 1)
> 
> - Improve Armada 38x device tree (SATA and XHCI)
> - Fix SD Card and audio support for OpenRD board
> - Provide template for RS-232/485 configuration for the same board
> - Use a common dtsi file for linkstation boards
> - Add support for Buffalo Linkstation LS-QVL

Thanks, merged.


-Olof
