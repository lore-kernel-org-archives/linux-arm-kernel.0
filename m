From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Feb 2016 15:59:17 +0100
Subject: [PATCH V2 09/12] dtb: amd: Add KCS device tree node
In-Reply-To: <1454954357-8395-10-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1454954357-8395-10-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <4018438.bPuTyoUuqf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 February 2016 11:59:14 Suravee Suthikulpanit wrote:
> +
> +               ipmi_kcs: kcs at e0010000 {
> +                       status = "disabled";
> +                       compatible = "ipmi-kcs";
> +                       device_type = "ipmi";
> +                       reg = <0x0 0xe0010000 0 0x8>;
> +                       interrupts = <0 389 4>;
> +                       interrupt-names = "ipmi_kcs";
> +                       reg-size = <1>;
> +                       reg-spacing = <4>;
> +               };
>         };
> 

I see we don't have a binding file for this, can you add one please?


Why the strange name for the interrupt?

	Arnd
