From: dt.tangr@gmail.com (Daniel Tang)
Date: Mon, 25 Nov 2013 14:52:51 +1100
Subject: [PATCHv2] usb: chipidea: add support for USB OTG controller on
 TI-NSPIRE
In-Reply-To: <20131124101205.GA30724@shlinux1.ap.freescale.net>
References: <1385278667-91856-1-git-send-email-dt.tangr@gmail.com>
 <20131124101205.GA30724@shlinux1.ap.freescale.net>
Message-ID: <B462ABF6-2CD1-423F-8841-4D3A5C555751@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24/11/2013, at 9:12 PM, Peter Chen <Peter.Chen@freescale.com> wrote:

> On Sun, Nov 24, 2013 at 06:37:47PM +1100, dt.tangr at gmail.com wrote:
> 
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, ci_hdrc_nspire_dt_ids);
>> +module_platform_driver(ci_hdrc_nspire_driver);
>> +
>> +MODULE_ALIAS("platform:nspire_usb");
>> +MODULE_ALIAS("platform:ci_hdrc_nspire");
> 
> Just curious, why you need to two alias?

Oops, I must've forgotten to remove this. I'll remove it in the next patch.

> 
> -- 
> 
> Best Regards,
> Peter Chen
> 

Cheers,
Daniel Tang
