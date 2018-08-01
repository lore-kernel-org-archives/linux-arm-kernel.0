From: tiwai@suse.de (Takashi Iwai)
Date: Wed, 01 Aug 2018 14:01:25 +0200
Subject: [PATCH 4/9] ALSA: ens137x: remove redundant array pcm_devs
In-Reply-To: <20180801104742.4328-5-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
 <20180801104742.4328-5-colin.king@canonical.com>
Message-ID: <s5hd0v2nvmy.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 01 Aug 2018 12:47:37 +0200,
Colin King wrote:
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> The array pcm_devs is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'pcm_devs' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks.


Takashi
