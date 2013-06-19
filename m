From: sameo@linux.intel.com (Samuel Ortiz)
Date: Wed, 19 Jun 2013 11:34:02 +0200
Subject: [PATCH v2] mfd: vexpress: Make the driver optional for arm and
 arm64
In-Reply-To: <1370948162-18895-1-git-send-email-pawel.moll@arm.com>
References: <20130610232249.GH18614@n2100.arm.linux.org.uk>
 <1370948162-18895-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20130619093402.GY7161@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On Tue, Jun 11, 2013 at 11:56:02AM +0100, Pawel Moll wrote:
> The driver can be used on either arm or arm64 platforms, but
> the latter doesn't have any platform-specific configuration
> options, so it must be possible to manually enable the driver.
> 
> As the gpiolib is optional for arm64 arch, the gpio/led code
> must be compiled conditionally.
The real solution would be to move the GPIO code away from the MFD
driver, as we agreed on another thread.
Based on this agreement, I'm taking this one for now, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
