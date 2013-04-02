From: olof@lixom.net (Olof Johansson)
Date: Tue, 2 Apr 2013 10:20:36 -0700
Subject: [PATCH] arm: vt8500: Add wm8850 config options to
 multi_v7_defconfig
In-Reply-To: <1364199100-12300-1-git-send-email-linux@prisktech.co.nz>
References: <1364199100-12300-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130402172036.GG25867@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 09:11:40PM +1300, Tony Prisk wrote:
> This patch finally adds the WM8850 SoC to the multi_v7_defconfig.
> We don't have a seperate defconfig for this SoC as it is only
> available as a multiplatform option.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>


Applied to next/multiplatform after fixing up some conflicts due to the SPEAR
additions.


-Olof
