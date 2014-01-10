From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 10 Jan 2014 10:22:26 +0100
Subject: [PATCH] arm64: dts:  add <dt-bindings/> symlink
In-Reply-To: <1389346197-5127-1-git-send-email-pankaj.dubey@samsung.com>
References: <1389346197-5127-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20140110102226.63f5bf30@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Pankaj Dubey wrote:
> Add symlink to include/dt-bindings from arch/arm64/boot/dts/include/ to
> match the ones in ARM architectures so that preprocessed device
> tree files can include various useful constant definitions.
> 
> See commit c58299a (kbuild: create an "include chroot" for DT bindings)
> merged in v3.10-rc1 for details.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm64/boot/dts/include/dt-bindings |    1 +
>  1 file changed, 1 insertion(+)
>  create mode 120000 arch/arm64/boot/dts/include/dt-bindings
> 
> diff --git a/arch/arm64/boot/dts/include/dt-bindings b/arch/arm64/boot/dts/include/dt-bindings
> new file mode 120000
> index 0000000..08c00e4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/include/dt-bindings
> @@ -0,0 +1 @@
> +../../../../../include/dt-bindings
> \ No newline at end of file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
