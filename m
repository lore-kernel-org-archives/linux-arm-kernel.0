From: greg@kroah.com (Greg KH)
Date: Mon, 26 Oct 2009 16:43:32 -0700
Subject: staging/dream: add gpio and pmem support
In-Reply-To: <20091022091333.GA31023@elf.ucw.cz>
References: <20091022091333.GA31023@elf.ucw.cz>
Message-ID: <20091026234332.GB26583@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2009 at 11:13:34AM +0200, Pavel Machek wrote:
> 
> This adds generic_gpio and pmem support, both are needed for other
> dream drivers.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

I'd prefer to get the existing code building, before adding new stuff :(

thanks,

greg k-h
