From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 25 Oct 2016 09:55:15 +0200
Subject: [PATCH 3/5] staging/vchi: Fix some pointer math for 64-bit.
In-Reply-To: <20161017194406.1080-4-eric@anholt.net>
References: <20161017194406.1080-1-eric@anholt.net>
 <20161017194406.1080-4-eric@anholt.net>
Message-ID: <20161025075515.GA29765@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 12:44:04PM -0700, Eric Anholt wrote:
> These were throwing warnings on aarch64, and all are trivially
> converted to longs.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 6 +++---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c     | 5 +++--
>  2 files changed, 6 insertions(+), 5 deletions(-)

This didnt apply anymore as I think I took the other fixups, sorry.

greg k-h
