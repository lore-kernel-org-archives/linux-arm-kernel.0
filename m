From: olof@lixom.net (Olof Johansson)
Date: Tue, 14 Jun 2016 10:26:39 -0700
Subject: [GIT PULL] ARM: at91: dt for 4.8 #1
In-Reply-To: <20160612112120.GA25664@piout.net>
References: <20160612112120.GA25664@piout.net>
Message-ID: <20160614172639.GC9200@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2016 at 01:21:20PM +0200, Alexandre Belloni wrote:
> Arnd, Olof, Kevin,
> 
> First DT changes for 4.8 with the addition of a new board and a cleanup
> of unused clock definitions.
> 
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.8-dt
> 
> for you to fetch changes up to 64c0703e269d442f0406b34e64e23744151ea276:
> 
>   ARM: dts: at91: calao: remove leftovers clock definition (2016-06-10 16:59:30 +0200)
> 
> ----------------------------------------------------------------
> DT Changes for 4.8:
>  - New board: Olimex SAM9-L9260
>  - Fix crystal definitions for Denx ma5d4
>  - Remove leftover clock definitions
>  - Add stdout-path for usb_a9260/a9g20

Thanks, merged.


-Olof
