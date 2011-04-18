From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2011 08:54:35 +0200
Subject: [PATCH V14 1/4] ptp: Added a brand new class driver for ptp
	clocks.
In-Reply-To: <7cabcc0bbd14733fa979fe08deccab8939204f24.1303107532.git.richard.cochran@omicron.at>
References: <cover.1303107532.git.richard.cochran@omicron.at>
	<7cabcc0bbd14733fa979fe08deccab8939204f24.1303107532.git.richard.cochran@omicron.at>
Message-ID: <201104180854.35552.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2011, Richard Cochran wrote:
> This patch adds an infrastructure for hardware clocks that implement
> IEEE 1588, the Precision Time Protocol (PTP). A class driver offers a
> registration method to particular hardware clock drivers. Each clock is
> presented as a standard POSIX clock.
> 
> The ancillary clock features are exposed in two different ways, via
> the sysfs and by a character device.
> 
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>

Acked-by: Arnd Bergmann <arnd@arndb.de>
