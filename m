From: andy.gross@linaro.org (Andy Gross)
Date: Sun, 5 Jun 2016 14:03:34 -0500
Subject: [PATCH 1/3] tty: serial: msm: Move header file into driver
In-Reply-To: <20160512010228.21548-2-sboyd@codeaurora.org>
References: <20160512010228.21548-1-sboyd@codeaurora.org>
 <20160512010228.21548-2-sboyd@codeaurora.org>
Message-ID: <20160605190334.GG13357@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 06:02:26PM -0700, Stephen Boyd wrote:
> This header file is only used by the driver, so let's merge the
> two together to reduce files and make it easier to see the whole
> driver without flipping through two files. This also makes it
> easier to use the structures defined in msm_serial.c in the
> functions that are defined in msm_serial.h by placing them in the
> proper locations.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Andy Gross <andy.gross@linaro.org>
