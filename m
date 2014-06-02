From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 02 Jun 2014 13:57:49 +0100
Subject: [PATCH v4 00/20] arm64: GICv3 support
In-Reply-To: <CAC8NTUWuuUrHKp4a1WkqSfiPNZjbwffBn-u7DGsrB8eF65e_ig@mail.gmail.com>
 (Radha Mohan's message of "Sat, 31 May 2014 00:06:57 +0100")
References: <1400176719-31275-1-git-send-email-marc.zyngier@arm.com>
 <CAC8NTUWuuUrHKp4a1WkqSfiPNZjbwffBn-u7DGsrB8eF65e_ig@mail.gmail.com>
Message-ID: <87k38z1naq.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 31 2014 at 12:06:57 am BST, Radha Mohan <mohun106@gmail.com> wrote:
> Hi Marc,
> The patch set is working for us on our platform. Below are some of the
> things we tested with the GICv3 driver.
>
> System: Cavium's proprietary simulator
> Cores: 16
> GIC version: GICv3
>
> 1) SGI, PPI and SPI
> 2) MSI and MSI-x with SPI and also LPI (took previous version of an
> unposted LPI/ITS driver which now is missing from Marc's git tree)
>
> The kind of devices that were tested are UARTs, AHCI controller,
> SR-IOV capable devices.
>
> So,
> Acked-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> Tested-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

Thanks. I suppose this only applies to the first few patches, as you
don't mention KVM here?

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny.
