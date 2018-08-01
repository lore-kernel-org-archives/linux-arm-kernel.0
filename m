From: tiwai@suse.de (Takashi Iwai)
Date: Wed, 01 Aug 2018 14:01:04 +0200
Subject: [PATCH 2/9] ALSA: cs5535audio: remove redundant pointer 'dma'
In-Reply-To: <20180801104742.4328-3-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
 <20180801104742.4328-3-colin.king@canonical.com>
Message-ID: <s5hftzynvnj.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 01 Aug 2018 12:47:35 +0200,
Colin King wrote:
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer 'dma' is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up two clang warnings:
> warning: variable 'dma' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks.


Takashi
