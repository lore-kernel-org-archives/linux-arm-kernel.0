From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 18 Jan 2017 08:06:38 +0100
Subject: [PATCH net-next v4 05/10] drivers: base: Add
 device_find_in_class_name()
In-Reply-To: <20170117232152.1661-6-f.fainelli@gmail.com>
References: <20170117232152.1661-1-f.fainelli@gmail.com>
 <20170117232152.1661-6-f.fainelli@gmail.com>
Message-ID: <20170118070638.GA28945@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 03:21:47PM -0800, Florian Fainelli wrote:
> Add a helper function to lookup a device reference given a class name.
> This is a preliminary patch to remove adhoc code from net/dsa/dsa.c and
> make it more generic.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/base/core.c    | 31 +++++++++++++++++++++++++++++++
>  include/linux/device.h |  2 ++
>  2 files changed, 33 insertions(+)

My NAK still stands here, please give me a day or so to respond to the
other thread about this...

thanks,

greg k-h
