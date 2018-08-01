From: tiwai@suse.de (Takashi Iwai)
Date: Wed, 01 Aug 2018 14:00:52 +0200
Subject: [PATCH 1/9] ALSA: asihpi: remove redundant variable max_streams
In-Reply-To: <20180801104742.4328-2-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
 <20180801104742.4328-2-colin.king@canonical.com>
Message-ID: <s5hh8kenvnv.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 01 Aug 2018 12:47:34 +0200,
Colin King wrote:
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable max_streams is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'max_streams' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks.


Takashi
