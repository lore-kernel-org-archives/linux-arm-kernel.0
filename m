From: kurt.van.dijck@eia.be (Kurt Van Dijck)
Date: Fri, 11 Feb 2011 16:06:02 +0100
Subject: [PATCH v2 09/13] can: pruss CAN driver.
In-Reply-To: <1297435892-28278-10-git-send-email-subhasish@mistralsolutions.com>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-10-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <20110211150602.GB373@e-circ.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 08:21:28PM +0530, Subhasish Ghosh wrote:
> +config DA8XX_PRU_CANID_MBX0
> +	hex "CANID for mailbox 0"
> +	depends on CAN_TI_DA8XX_PRU
> +	default "0x123"
> +	---help---
> +	Enter the CANID for mailbox 0
> +	Default value is set to 0x123, change this as required.
> +
> +config DA8XX_PRU_CANID_MBX1
> +	hex "CANID for mailbox 1"
> +	depends on CAN_TI_DA8XX_PRU
> +	default "0x123"
> +	 ---help---
> +	Enter the CANID for mailbox 1
> +	Default value is set to 0x123, change this as required.
> +
> +config DA8XX_PRU_CANID_MBX2
> +	hex "CANID for mailbox 2"
> +	depends on CAN_TI_DA8XX_PRU
> +	default "0x123"
> +	---help---
> +	Enter the CANID for mailbox 2
> +	Default value is set to 0x123, change this as required.
> +
> +config DA8XX_PRU_CANID_MBX3
> +	hex "CANID for mailbox 3"
> +	depends on CAN_TI_DA8XX_PRU
> +	default "0x123"
> +	---help---
> +	Enter the CANID for mailbox 3
> +	Default value is set to 0x123, change this as required.
> +
> +config DA8XX_PRU_CANID_MBX4
> +	hex "CANID for mailbox 4"
> +	depends on CAN_TI_DA8XX_PRU
> +	default "0x123"
> +	---help---
> +	Enter the CANID for mailbox 4
> +	Default value is set to 0x123, change this as required.
> +
> +config DA8XX_PRU_CANID_MBX5
> +	hex "CANID for mailbox 5"
> +	depends on CAN_TI_DA8XX_PRU
> +	default "0x123"
> +	---help---
> +	Enter the CANID for mailbox 5
> +	Default value is set to 0x123, change this as required.
> +
> +config DA8XX_PRU_CANID_MBX6
> +	hex "CANID for mailbox 6"
> +	depends on CAN_TI_DA8XX_PRU
> +	default "0x123"
> +	---help---
> +	Enter the CANID for mailbox 6
> +	Default value is set to 0x123, change this as required.
> +
> +config DA8XX_PRU_CANID_MBX7
> +	hex "CANID for mailbox 7"
> +	depends on CAN_TI_DA8XX_PRU
> +	default "0x123"
> +	---help---
> +	Enter the CANID for mailbox 7
> +	Default value is set to 0x123, change this as required.
Why is filling the mailboxes the job of kernel config?

Regards,
Kurt
