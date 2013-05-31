From: dmurphy@ti.com (Dan Murphy)
Date: Fri, 31 May 2013 09:29:42 -0500
Subject: [PATCH v7] ARM: dts: omap4-panda: Update the LED support for
 the panda DTS
In-Reply-To: <51A8AE72.5010601@ti.com>
References: <1369826427-31963-1-git-send-email-dmurphy@ti.com>
 <51A8AE72.5010601@ti.com>
Message-ID: <51A8B3D6.1020608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
On 05/31/2013 09:06 AM, Benoit Cousson wrote:
> Hi Dan,
>
> On 05/29/2013 01:20 PM, Dan Murphy wrote:
>> The GPIO for LED D1 on the omap4-panda a1-a3 rev and the omap4-panda-es
>> are different.
>>
>> A1-A3 = gpio_wk7clean
>> ES = gpio_110
>>
>> There is no change to LED D2
>>
>> Abstract away the pinmux and the LED definitions for the two boards into
>> the respective DTS files.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> That patch was good... until Florian introduces some new constant to
> improve the readability of the DTS [1].
>
> Could you rebase on the lastest for_3.11/dts and use the macros for the
> GPIO and pinctrl nodes?
N/P working on it now

Thanks
> Thanks,
> Benoit
>
> [1] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg89684.html
>

-- 
------------------
Dan Murphy
