From: tj@kernel.org (Tejun Heo)
Date: Mon, 20 Jan 2014 07:28:47 -0500
Subject: [RFC v3 05/13] ahci-platform: Pass ahci_host_priv ptr to
 ahci_platform_data init method
In-Reply-To: <52DC2DD9.7070403@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-6-git-send-email-hdegoede@redhat.com>
 <20140119113051.GD11123@htj.dyndns.org>
 <52DC1EC4.3090807@redhat.com>
 <20140119191706.GC32165@mtj.dyndns.org>
 <52DC2DD9.7070403@redhat.com>
Message-ID: <20140120122847.GC17155@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 08:56:09PM +0100, Hans de Goede wrote:
> Ok, asking the obvious here I guess, but you would accept a patch moving drivers/ata/ahci.h
> to include/linux as part of this patch-set ?

Wouldn't creating a minimal file which only contains the necessary
bits make more sense?

Thanks.

-- 
tejun
