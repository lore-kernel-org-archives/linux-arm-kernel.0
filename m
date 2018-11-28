From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 28 Nov 2018 16:41:44 +0800
Subject: [PATCH v3 1/3] ARM: imx_v6_v7_defconfig: Remove explicit
 ARM_UNWIND disable
In-Reply-To: <20181125222027.22071-1-otavio@ossystems.com.br>
References: <20181125222027.22071-1-otavio@ossystems.com.br>
Message-ID: <20181128084142.GN20643@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 25, 2018 at 08:20:25PM -0200, Otavio Salvador wrote:
> CONFIG_ARM_UNWIND is removed when running 'savedefconfig', but
> selected by ARM EABI (AEBI) support.  This is done in preparation to making
> further changes to this defconfig cleaner.
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

Applied all, thanks.
