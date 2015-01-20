From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Jan 2015 16:42:49 +0800
Subject: [PATCH] ARM: vf610: use zero based naming for GPIO nodes
In-Reply-To: <1421427975-16391-1-git-send-email-stefan@agner.ch>
References: <1421427975-16391-1-git-send-email-stefan@agner.ch>
Message-ID: <20150120084247.GZ2766@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 06:06:15PM +0100, Stefan Agner wrote:
> On Vybrid, all peripherals are numbered starting with zero,
> including the GPIO and PORT module. However, the labels of the
> corresponding device tree nodes start with one, which is confusing.
> Fix that by renaming the labels of the gpio nodes in the device
> tree.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Yep, this makes sense since Vybrid Reference Manual is numbering GPIO
port from 0.

Applied, thanks.
