From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Mon, 28 May 2012 16:52:50 +0530
Subject: [PATCHv9 07/10] I2C: OMAP: Handle error check for pm runtime
In-Reply-To: <87likfkjar.fsf@ti.com>
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
 <1335969135-20858-8-git-send-email-shubhrajyoti@ti.com>
 <87likfkjar.fsf@ti.com>
Message-ID: <4FC3600A.7010407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 26 May 2012 03:36 AM, Kevin Hilman wrote:
>> +	r = pm_runtime_get_sync(dev->dev);
>> > +	if (r < 0)
>> > +		return r;
> nit: please use IS_ERR_VALUE() 
Will fix that and resend.
> Kevin
