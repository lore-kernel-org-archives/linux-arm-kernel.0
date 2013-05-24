From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Fri, 24 May 2013 15:12:49 +0200
Subject: LVDS (LDB) driver for i.MX53 IPU
In-Reply-To: <Pine.LNX.4.64.1305241431460.2226@axis700.grange>
References: <5134DF0E.7010402@parkeon.com>
 <20130310223241.GQ1906@pengutronix.de>
 <Pine.LNX.4.64.1305241431460.2226@axis700.grange>
Message-ID: <519F6751.7020706@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

On 24/05/13 14:35, Guennadi Liakhovetski wrote:
> Hi Sascha
>
> On Sun, 10 Mar 2013, Sascha Hauer wrote:
>
>>
>> We have a driver for the ldb. Indeed the driver itself is trivial, but
>> the integration is tricky. For accessing the register the syscon binding
>> can be used. The clock is also a problem, also the mux to the IPU(s)
>>
>> I'll talk with Philipp tomorrow and I think we can send you the current
>> state then.
> How's it looking in the meantime? Any plans to mainline it? Or would you
> be prepared to publish what you've got to try and see whether others can
> help you with this?
Philipp submitted them on March 28 "[PATCH v3 0/11] LVDS Display Bridge 
support for i.MX"
The drivers/staging parts don't seem to have been applied (not in 
linux/next at any rate)

I've added them to my local tree and they work fine (on i.MX53)

Martin
