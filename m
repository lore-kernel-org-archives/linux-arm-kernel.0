From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 9 Jun 2016 14:21:01 -0500
Subject: [PATCH] tty: serial: msm: fix definition of msm_stop_dma
In-Reply-To: <1465323112-32366-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465323112-32366-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160609192101.GK13357@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 07:11:52PM +0100, Ben Dooks wrote:
> The msm_stop_dma() is not exported from the driver, so make
> it static to stop the following warning:
> 
> drivers/tty/serial/msm_serial.c:84:6: warning: symbol 'msm_stop_dma' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Good find.

Acked-by: Andy Gross <andy.gross@linaro.org>
