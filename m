From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 11 Aug 2010 19:01:20 +0300
Subject: [PATCH v3 8/9] omap: hsmmc: split mmc23 power control
In-Reply-To: <4C6275F3.6030108@nokia.com>
References: <1281478348-24833-1-git-send-email-ohad@wizery.com>
	<1281478348-24833-9-git-send-email-ohad@wizery.com>
	<4C6275F3.6030108@nokia.com>
Message-ID: <AANLkTinYn2NQFeS8GocmTgU20Cc24Ax+RSbMLGz3KGom@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 1:05 PM, Adrian Hunter <adrian.hunter@nokia.com> wrote:
> Ohad Ben-Cohen wrote:
>>
>> Prepare for mmc3 regulator power control by splitting the power
>> control functions of mmc2 and mmc3, and expecting mmc3 to have
>> a single, dedicated, regulator support.
>
> Why? ?Can't the controller be connected to an eMMC with 2 power
> supplies? ?At a glance, it is not obvious why this patch is needed.

I had ZOOM too much in mind when I did that. Removed now, thanks !
