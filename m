From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 4 Oct 2016 12:52:17 +0200
Subject: [PATCH 05/14] mfd: sun6i-prcm: Add sun8i analog codec as subnode
In-Reply-To: <c74aea452bd1831f439dd67884cb2879e0849f03.1475571575.git.mylene.josserand@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <c74aea452bd1831f439dd67884cb2879e0849f03.1475571575.git.mylene.josserand@free-electrons.com>
Message-ID: <20161004125217.952342ecac68d3da3336cc76@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  4 Oct 2016 11:46:18 +0200
Myl?ne Josserand <mylene.josserand@free-electrons.com> wrote:

> The sun8i audio codec is using PRCM registers to configure all the
> analog part of the audio codec. It is added as a subnode of the PRCM
> with his resource (offset of 0x1c0).
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  drivers/mfd/sun6i-prcm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
	[snip]

I was heard that the PRCM as a MFD would disappear.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
