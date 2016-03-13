From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Mar 2016 17:42:49 -0800
Subject: Amlogic Meson ARM64 DTS changes for 4.6
In-Reply-To: <CAOQ7t2YQg01vdBQwQNWiij8A0j1Vr0Zyvj01gw+QZ1L8pSHHkw@mail.gmail.com>
References: <CAOQ7t2YQg01vdBQwQNWiij8A0j1Vr0Zyvj01gw+QZ1L8pSHHkw@mail.gmail.com>
Message-ID: <20160313014249.GG5883@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 07, 2016 at 01:21:07PM +0100, Carlo Caione wrote:
> The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:
> 
>   Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)
> 
> are available in the git repository at:
> 
>   https://github.com/carlocaione/linux-meson.git tags/for-v4.6/gxbb-dt
> 
> for you to fetch changes up to cc733bc90636118b20aad8ce7421001b679b338a:
> 
>   ARM64: dts: amlogic: Add Tronsmart Vega S95 configs (2016-03-07
> 11:12:40 +0100)
> 
> ----------------------------------------------------------------
> This series adds initial support for the Amlogic S905 based
> Tronsmart Vega S95 Pro, Meta and Telos TV boxes.
> 
> - Add new DTS to enable support for the boards
> - Add documentation for compatibles and vendor prefix

It's usually too late in the release cycle for us to merge substantially new
material. Please try to get the bulk of new code to us by -rc4-5 if you can.
Incremental pull requests with smaller additions/fixes are fine later as well.

However, I see that this is mostly DT additions so I'll pick it up this time
around.

Merged, thanks.


-Olof
