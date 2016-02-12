From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 11 Feb 2016 19:15:51 -0800
Subject: [PATCH v8 2/4] tee: generic TEE subsystem
In-Reply-To: <1455210877-15748-3-git-send-email-jens.wiklander@linaro.org>
References: <1455210877-15748-1-git-send-email-jens.wiklander@linaro.org>
 <1455210877-15748-3-git-send-email-jens.wiklander@linaro.org>
Message-ID: <20160212031551.GA10157@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 06:14:35PM +0100, Jens Wiklander wrote:
> Initial patch for generic TEE subsystem.
> This subsystem provides:
> * Registration/un-registration of TEE drivers.
> * Shared memory between normal world and secure world.
> * Ioctl interface for interaction with user space.
> * Sysfs implementation_id of TEE driver
> 
> A TEE (Trusted Execution Environment) driver is a driver that interfaces
> with a trusted OS running in some secure environment, for example,
> TrustZone on ARM cpus, or a separate secure co-processor etc.
> 
> The TEE subsystem can serve a TEE driver for a Global Platform compliant
> TEE, but it's not limited to only Global Platform TEEs.
> 
> This patch builds on other similar implementations trying to solve
> the same problem:
> * "optee_linuxdriver" by among others
>   Jean-michel DELORME<jean-michel.delorme@st.com> and
>   Emmanuel MICHEL <emmanuel.michel@st.com>
> * "Generic TrustZone Driver" by Javier Gonz?lez <javier@javigon.com>
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

I need you to get other people to review this before I can accept this
series.  Please do that, surely someone else cares about this code
becides you?

thanks,

greg k-h
