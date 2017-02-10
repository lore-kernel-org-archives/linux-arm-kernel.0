From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 10 Feb 2017 15:21:19 +0100
Subject: [PATCH v3 04/18] drivers/fsi: Add fsi master definition
In-Reply-To: <20170201165358.45415-5-cbostic@linux.vnet.ibm.com>
References: <20170201165358.45415-1-cbostic@linux.vnet.ibm.com>
 <20170201165358.45415-5-cbostic@linux.vnet.ibm.com>
Message-ID: <20170210142119.GA13386@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 10:53:44AM -0600, Christopher Bostic wrote:
> From: Jeremy Kerr <jk@ozlabs.org>
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
> ---
>  drivers/fsi/fsi-core.c   | 28 ++++++++++++++++++++++++++++
>  drivers/fsi/fsi-master.h | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
>  create mode 100644 drivers/fsi/fsi-master.h

I can't take patches without any changelog text, so please fix up and
resend the remaining patches in the series.

thanks,

greg k-h
