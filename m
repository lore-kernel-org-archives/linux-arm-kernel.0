From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 7 Oct 2015 13:56:31 +0100
Subject: [PATCH v2 3/3] nvmem: core: add sysfs file mode flag in
 nvmem_config
In-Reply-To: <1444215664-10921-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1444215536-10783-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1444215664-10921-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20151007125631.GC7962@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 12:01:04PM +0100, Srinivas Kandagatla wrote:
> This patch adds mode variable to nvmem_config structure which will allow
> providers to specify the permissions for the sysfs binary file.
> This mode is applied on top of root-only access permissions set by
> the core.
> 
> Having this flag would give more flexibility to providers to decide
> which permissions to set on the sysfs binary file entry.

And they will get it wrong, please don't do this.

thanks,

greg k-h
