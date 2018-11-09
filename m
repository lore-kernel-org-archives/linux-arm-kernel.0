From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 9 Nov 2018 09:05:26 -0800
Subject: [PATCH 7/9] serial: Add Tegra Combined UART driver
In-Reply-To: <20181026111638.10759-8-thierry.reding@gmail.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
 <20181026111638.10759-8-thierry.reding@gmail.com>
Message-ID: <20181109170526.GB14151@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2018 at 01:16:36PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
> multiplexing multiple "virtual UARTs" into a single hardware serial
> port. The TCU is the primary serial port on Tegra194 devices.
> 
> Add a TCU driver utilizing the mailbox framework, as the used mailboxes
> are part of Tegra HSP blocks that are already controlled by the Tegra
> HSP mailbox driver.
> 
> Based on work by  Mikko Perttunen <mperttunen@nvidia.com>.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
