From: dyoung@redhat.com (Dave Young)
Date: Thu, 21 Jan 2016 11:03:22 +0800
Subject: [PATCH 18/19] arm64: kdump: update a kernel doc
In-Reply-To: <20160120115436.GC25829@leverpostej>
References: <20160119014332.GB2919@dhcp-128-65.nay.redhat.com>
 <569DCB30.9010501@linaro.org>
 <20160119122848.GA2904@dhcp-128-65.nay.redhat.com>
 <20160119125114.GH25024@leverpostej>
 <20160119134553.GA2986@dhcp-128-65.nay.redhat.com>
 <20160119140139.GC26545@leverpostej>
 <20160120024946.GA2999@dhcp-128-65.nay.redhat.com>
 <569F2439.9000604@linaro.org>
 <20160120063856.GA3725@dhcp-128-65.nay.redhat.com>
 <20160120115436.GC25829@leverpostej>
Message-ID: <20160121030322.GC7950@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I am strongly opposed to modifying the FW-provided memroy map
> information, for the reasons I expressed in other replies.
> 
> What are your concerns with a property under /chosen?

If we choose a simpler way between memmap= and /chosen property then
I think a property in /chosen looks better to me.

Thanks
Dave
