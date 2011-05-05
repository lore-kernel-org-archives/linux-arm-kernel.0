From: julian.calaby@gmail.com (Julian Calaby)
Date: Fri, 6 May 2011 08:59:23 +1000
Subject: [PATCH][WAS:bcmai,
	axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
Message-ID: <BANLkTi=epFN2EZBj9n8pac6h7F4RWmyk+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rafa?,

A minor nit:

On Fri, May 6, 2011 at 07:59, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> diff --git a/Documentation/ABI/testing/sysfs-bus-bcma b/Documentation/ABI/testing/sysfs-bus-bcma
> new file mode 100644
> index 0000000..ad3cd69
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-bcma
> @@ -0,0 +1,31 @@
> +What: ? ? ? ? ?/sys/bus/bcma/devices/.../class
> +Date: ? ? ? ? ?May 2011
> +KernelVersion: 2.6.40
> +Contact: ? ? ? Rafa? Mi?ecki <zajec5@gmail.com>
> +Description:
> + ? ? ? ? ? ? ? Each AXI core is identified by few fields, including class it
> + ? ? ? ? ? ? ? belongs to. See include/linux/bcma/bcma.h for possible values.

Should this not read BCMA or something similar, not AXI?

Ditto for the rest of the changes to this file.

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
