From: sboyd@kernel.org (Stephen Boyd)
Date: Thu, 30 Aug 2018 18:29:58 -0700
Subject: [PATCH] clk: mediatek: remove unused array audio_parents
In-Reply-To: <20180806134402.1055-1-colin.king@canonical.com>
References: <20180806134402.1055-1-colin.king@canonical.com>
Message-ID: <153567899849.93865.4205043107104480951@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Colin King (2018-08-06 06:44:02)
> From: Colin Ian King <colin.king@canonical.com>
> 
> Array audio_parents is declared but never used, hence it is redundant
> and can be removed.
> 
> Cleans up clang warning:
> warning: 'audio_parents' defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to clk-next
