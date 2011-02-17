From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 17 Feb 2011 16:49:52 +0000
Subject: [RFC PATCH] picoxcell_fuse: add support for the picoXcell fuse
	block
In-Reply-To: <1297092390-10610-1-git-send-email-jamie@jamieiles.com>
References: <1297092390-10610-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20110217164952.GD941@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 07, 2011 at 03:26:30PM +0000, Jamie Iles wrote:
> Picochip picoXcell devices contain a fuse block that controls
> aspects of the device such as disabling JTAG, disabling the ARM
> memory controller, secure booting and storing secure keys. This
> driver provides a character device to read and write the fuse
> values and exports the fuse ranges to sysfs.
> 
> Platforms should add a struct picoxcell_fuse_map to the platform
> device platform_data defining all of the fuse ranges and protection
> bits.
> 
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

Does anyone have any feedback on this driver?

Thanks,

Jamie
