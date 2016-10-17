From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 17 Oct 2016 22:28:54 +0200
Subject: [PATCH 1/5] staging/vchi: Fix build error in debugfs ops on
 aarch64.
In-Reply-To: <20161017194406.1080-2-eric@anholt.net>
References: <20161017194406.1080-1-eric@anholt.net>
 <20161017194406.1080-2-eric@anholt.net>
Message-ID: <20161017202854.GA30183@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 12:44:02PM -0700, Eric Anholt wrote:
> file_operations.write returns a ssize_t, which worked out fine on 32
> bit but errors out on 64 bit.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I also have already fixed this one :)
