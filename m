From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 24 Jan 2012 09:58:26 +0900
Subject: [PATCH] arm: fix compile failure in mach-shmobile/board-ag5evm.c
In-Reply-To: <1327262245-21049-1-git-send-email-paul.gortmaker@windriver.com>
References: <1327262245-21049-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20120124005826.GB32319@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2012 at 02:57:25PM -0500, Paul Gortmaker wrote:
> Add videodev2 header which provides V4L2_PIX_FMT_RGB565 to fix:
> 
> arch/arm/mach-shmobile/board-ag5evm.c:274: error: 'V4L2_PIX_FMT_RGB565' undeclared here (not in a function)
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
Applied, thanks.
