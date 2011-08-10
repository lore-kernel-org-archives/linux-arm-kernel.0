From: gregkh@suse.de (Greg KH)
Date: Wed, 10 Aug 2011 08:02:51 -0700
Subject: [PATCH 2/4] Add documenation for new sysfs devices/soc
	functionallity
In-Reply-To: <1312981422-13294-2-git-send-email-lee.jones@linaro.org>
References: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
	<1312981422-13294-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20110810150251.GD7938@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 02:03:40PM +0100, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/ABI/testing/sysfs-devices-soc |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-soc
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-soc b/Documentation/ABI/testing/sysfs-devices-soc
> new file mode 100644
> index 0000000..9156ba0
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-soc
> @@ -0,0 +1,16 @@
> +What:		/sys/devices/soc
> +Date:		April 2011
> +contact:	Lee Jones <lee.jones@linaro.org>
> +Description:
> +		The /sys/devices/soc directory contains a sub-directory for each
> +		System-on-Chip (SoC) device on a running platform. Information
> +		regarding each SoC can be obtained by reading sysfs files. This
> +		functionallity is only available if implemented by the platform.
> +		This directory contains two kinds of attributes:
> +			- Common attributes:
> +				* machine: the name of the machine (e.g. Ux500).
> +				* family: the family name of the SoC (e.g. DB8500).
> +			- SoC-specific attributes:
> +				* SoC vendor declared, such as serial and rev numbers.

Spell out these individual files with individual entries please.
