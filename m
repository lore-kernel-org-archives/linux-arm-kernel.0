From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Sep 2018 09:51:27 +0100
Subject: [GIT PULL] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
In-Reply-To: <bd9104b702feec556ed01311e9efcb96790131d0.camel@upb.ro>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <20180910151803.GX28860@dell>
 <bd9104b702feec556ed01311e9efcb96790131d0.camel@upb.ro>
Message-ID: <20180911085127.GD4185@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Sep 2018, Radu Nicolae Pirea wrote:

> Hi Lee,
> 
> Thank you for taking the patch series, but you didn't take the latest
> version(v12) :)

Both were marked for merging in my inbox, and since I am working
though my (300+) post-vacation emails chronologically v11 was handled
first.

It appears as though there is an issue in the way 'struct
of_device_id' was declared too.  The header file in which it was
declared used to be included by proxy, however a separation has
recently been made causing build errors.

I will fix both issues and re-submit the PR.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
