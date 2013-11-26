From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 26 Nov 2013 13:30:14 -0500
Subject: [PATCH 07/12] memory: davinci-aemif: introduce AEMIF driver
In-Reply-To: <5294DE17.9080900@ti.com>
References: <1384187188-5776-1-git-send-email-ivan.khoronzhuk@ti.com>,
 <1384187188-5776-8-git-send-email-ivan.khoronzhuk@ti.com>
 <4F5844B3A985794BA902E12C070812375F8D2E@DNCE04.ent.ti.com>
 <52944BD3.90105@ti.com> <5294DE17.9080900@ti.com>
Message-ID: <5294E8B6.5000102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ivan,

On Tuesday 26 November 2013 12:44 PM, ivan.khoronzhuk wrote:
> On 11/26/2013 09:20 AM, Sekhar Nori wrote:
>> On Monday 11 November 2013 10:36 PM, Khoronzhuk, Ivan wrote:

>>> +static struct platform_driver davinci_aemif_driver = {
>>> +       .probe = davinci_aemif_probe,
>>> +       .remove = davinci_aemif_remove,
>>> +       .driver = {
>>> +               .name = DRV_NAME,
>>> +               .owner = THIS_MODULE,
>>> +               .of_match_table = of_match_ptr(davinci_aemif_of_match),
>>> +       },
>>> +};
>>> +
>>> +module_platform_driver(davinci_aemif_driver);
>>> +
>>> +MODULE_AUTHOR("Murali Karicheri <m-karicheri2@ti.com>");
>>
>> Is this correct? If yes, I would have expected him to sign-off on the
>> patch too. If not, please drop this.
> 
> I will add sign-off
> 
Please add you as a MODULE_AUTHOR as well since you re-wrote the
downstream driver. Ok to have both of you sign of on it.

Regards,
Santosh
