From: tiwai@suse.de (Takashi Iwai)
Date: Wed, 01 Aug 2018 14:01:13 +0200
Subject: [PATCH 3/9] ALSA: emu10k1: remove redundant variable attn
In-Reply-To: <20180801104742.4328-4-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
 <20180801104742.4328-4-colin.king@canonical.com>
Message-ID: <s5heffinvna.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 01 Aug 2018 12:47:36 +0200,
Colin King wrote:
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable attn is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'attn' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks.


Takashi
