From: tj@kernel.org (Tejun Heo)
Date: Sun, 19 Jan 2014 06:15:58 -0500
Subject: [RFC v3 02/13] sata-highbank: Remove unnecessary ahci_platform.h
 include
In-Reply-To: <1390088935-7193-3-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20140119111558.GB11123@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 12:48:44AM +0100, Hans de Goede wrote:
> The sata-highbank driver is a complete standalone sata driver, which does
> not use ahci_platform.c / ahci_platform_data in any way.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to libata/for-3.14.

Thanks.

-- 
tejun
