From: acourbot@nvidia.com (Alexandre Courbot)
Date: Fri, 8 Apr 2016 13:47:49 +0900
Subject: Nouveau crashes in 4.6-rc on arm64
In-Reply-To: <57064992.1060509@arm.com>
References: <57064992.1060509@arm.com>
Message-ID: <570737F5.30105@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 04/07/2016 08:50 PM, Robin Murphy wrote:
> Hello,
>
> With 4.6-rc2 (and -rc1) I'm seeing Nouveau blowing up at boot, from the
> look of it by dereferencing some offset from NULL inside
> nouveau_fbcon_imageblit(). My setup is an old XFX 7600GT card plugged
> into an ARM Juno r1 board, which works fine with 4.5 and earlier.
>
> Attached are a couple of logs from booting arm64 defconfig plus DRM and
> Nouveau enabled - the second also has framebuffer console rotation
> turned on, which interestingly seems to move the point of failure, and
> the display does eventually come up to show the tail end of the panic in
> that case.
>
> I might be able to find time for a full bisection next week if isn't
> something sufficiently obvious to anyone who knows this driver.

Looking at the log it is not clear to me what could be causing this. I 
can boot 4.6-rc2 with a GM206 card without any issue. A bisect would 
indeed be useful here.

Thanks,
Alex.
