From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 3 Aug 2013 14:14:24 -0400
Subject: [PATCH 2/2] ARM: mvebu: add gpio-keys and input event support
 in defconfig
In-Reply-To: <1375199091-31215-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375199091-31215-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375199091-31215-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130803181424.GE13555@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 05:44:51PM +0200, Thomas Petazzoni wrote:
> Some Armada 370/XP boards have GPIO buttons, so it makes sense to
> enable gpio-keys and the input event interface in mvebu_defconfig.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Applied to mvebu/defconfig

thx,

Jason.
