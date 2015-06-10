From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 10 Jun 2015 15:46:13 -0700
Subject: [PATCH] ARM: socfpga: dts: enable ethernet for Arria10 devkit
In-Reply-To: <1433298660-4204-1-git-send-email-dinh.linux@gmail.com> (dinh
 linux's message of "Tue, 2 Jun 2015 21:31:00 -0500")
References: <1433298660-4204-1-git-send-email-dinh.linux@gmail.com>
Message-ID: <7hzj47ji6i.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dinh.linux at gmail.com writes:

> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>
> Update the arria10 gmac nodes with all the necessary properties for ethernet
> to function on the Arria10 devkit.
>
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
> Hi Arnd, Kevin, Olof:
>
> Please apply this patch for v4.2. I couldn't add this patch to the pull
> request as this patch will cause a merge conflict if it was based on
> v4.1-rcX.

Applied to next/dt after merging your previous DT pull req.

Thanks,

Kevin
