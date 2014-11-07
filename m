From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Nov 2014 22:17:32 -0500
Subject: [PATCH 6/6] ARM: mvebu: update mvebu_v7_defconfig for Armada
 370 audio
In-Reply-To: <1414512524-24466-7-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-7-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20141107031732.GC3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 05:08:44PM +0100, Thomas Petazzoni wrote:
> Now that the Armada 370 DB audio complex is represented fully in
> Device Tree using the simple-card DT binding, this commit updates
> mvebu_v7_defconfig to no longer select the Armada 370 DB audio machine
> driver, and instead select the appropriate audio controller and codec
> drivers.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_v7_defconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to mvebu/defconfig with Andrew's Ack.

thx,

Jason.
